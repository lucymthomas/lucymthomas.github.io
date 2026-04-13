require 'bibtex'
require 'latex/decode'

module BibTeX
  module Filters
    # Replaces the standard LaTeX filter with one that first protects inline
    # math expressions ($...$  and  $$...$$) from being decoded, applies the
    # standard latex-to-unicode conversion to the remaining text, then
    # restores the math expressions unchanged for MathJax to render.
    class ProtectMath < Filter
      PLACEHOLDER = 'XMATHBLOCKX%dX'.freeze

      def apply(value)
        raw = value.to_s
        maths = []

        # Protect $$...$$ before $...$ to avoid partial matches.
        protected_raw = raw.gsub(/\$\$[^$]*\$\$|\$[^$\n]*\$/) do |m|
          idx = maths.size
          maths << m
          PLACEHOLDER % idx
        end

        # Apply the standard latex-to-unicode conversion to the math-free string.
        decoded = ::LaTeX.decode(protected_raw)

        # Restore the original math expressions.
        maths.each_with_index do |math, idx|
          decoded = decoded.gsub(PLACEHOLDER % idx, math)
        end

        decoded
      end
    end
  end
end
