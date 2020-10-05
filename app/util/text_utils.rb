module TextUtil
  BadRegexMatchError = Class.new(RegexpError)
  def match_or_throw(match_type, str, regex, match_number)
    mtch = str.match(regex)
    raise RegexpError, "NoMatchs for: `#{match_type}` Regex: #{regex.inspect} in `#{str}`" if mtch.nil? || (mtch.size <= match_number)

    mtch[match_number]
  end
end
