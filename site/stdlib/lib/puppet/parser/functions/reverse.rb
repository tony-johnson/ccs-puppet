#
# reverse.rb
#
module Puppet::Parser::Functions
  newfunction(:reverse, type: :rvalue, doc: <<-EOS
    Reverses the order of a string or array.
    EOS
             ) do |arguments|

    raise(Puppet::ParseError, "reverse(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.empty?

    value = arguments[0]

    unless value.is_a?(Array) || value.is_a?(String)
      raise(Puppet::ParseError, 'reverse(): Requires either array or string to work with')
    end

    result = value.reverse

    return result
  end
end

# vim: set ts=2 sw=2 et :
