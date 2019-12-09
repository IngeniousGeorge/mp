module I18n
  
  def self.default_language_hash
    # eval(ENV['DEFAULT_LANGUAGE']) #"{en: 'english'}"
    {en: 'english'}
  end

  def self.non_default_locales_hash 
    # eval(ENV['OTHER_LANGUAGES']) #"{fr: 'french'}"
    {fr: 'french'}
  end
end