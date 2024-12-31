
#
# cerata.rb

require 'stringio'


module Cerata

  VERSION = '1.0.0'

  module NoVal; end

  class << self

    # TODO deal with double width characters...

    def horizontal_a_to_s(a, indent='')

      return '[]' if a.empty?

      o = StringIO.new

      o << indent << '[ '
      a1 = a.dup; while e = a1.shift
        o << e.inspect
        o << ', ' if a1.any?
      end
      o << ' ]'

      o.string
    end

    def horizontal_h_to_s(h, indent='')

      return '{}' if h.empty?

      o = StringIO.new

      o << indent << '{ '
      kvs = h.to_a; while kv = kvs.shift
        o << "#{kv.first}: " << kv[1].inspect
        o << ', ' if kvs.any?
      end
      o << ' }'

      o.string
    end

    def vertical_h_to_s(h, indent='')

      return '{}' if h.empty?

      o = StringIO.new

      o << indent << "{\n"
      h.each { |k, v| o << indent << "#{k}: " << v.inspect << ",\n" }
      o << indent << '}'

      o.string
    end

    # A "table" here is an array of hashes
    #
    # This method emits a Ruby readable vertically aligned table-like
    # representation of the a input.
    # Beware: it turns all keys to symbols.
    #
    def table_to_s(a, indent='')

      return '[]' if a.empty?

      all_keys =
        a.collect(&:keys).flatten.uniq.map(&:to_s)
      key_widths =
        all_keys.inject({}) { |h, k| h[k] = k.length + 1; h }
          # +1 for the colon between key and value...
      val_widths =
        a.inject({}) { |w, h|
          h.each { |k, v|
            k = k.to_s
            w[k] = [ w[k] || 0, v.inspect.length ].max }
          w }

      o = StringIO.new

      o << indent << "[\n"

      a.each do |h|
        o << indent << '{ '
        all_keys.each_with_index do |k, i|
          sk = k.to_sym
          v =
            h.has_key?(k) ? h[k].inspect :
            h.has_key?(sk) ? h[sk].inspect :
            NoVal
          kl, vl = key_widths[k], val_widths[k]
          kf = "%#{kl}s"
          vf = v.is_a?(String) && (v[0, 1] == '"') ? "%-#{vl}s" : "%#{vl}s"
          o << ("#{kf} #{vf}" % (v == NoVal ? [ '', '' ] : [ k + ':', v ]))
          o << (v == NoVal ? '  ' : ', ') if i < all_keys.length - 1
        end
        o << " },\n"
      end

      o << indent << ']'

      o.string
    end

    #def term_length(s)
    #  s
    #    .chars
    #    .inject(0) { |r, c|
    #      c.match?(/[\p{Han}\p{Hiragana}\p{Katakana}]/) ? r + 2 :
    #      r + 1 }
    #end
    #alias tl term_length
  end
end

