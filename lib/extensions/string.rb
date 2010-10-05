# encoding: utf-8
class String
  TRANS_CHAR_MAP_CYR_0 = "абвгдезийклмнопрстуфхцыэъь".chars.to_a
  TRANS_CHAR_MAP_LAT_0 = "abvgdeziiklmnoprstufhcye''".chars.to_a
  TRANSLITERATION_CHARACTERS_MAP = (TRANS_CHAR_MAP_CYR_0.map {|c| [c, TRANS_CHAR_MAP_LAT_0[TRANS_CHAR_MAP_CYR_0.index(c)]] } |
                                   [
                                     ["ё", "yo"],
                                     ["ж", "zh"],
                                     ["ч", "ch"],
                                     ["ш", "sh"],
                                     ["щ", "sch"],
                                     ["ю", "yu"],
                                     ["я", "ya"]
                                   ]).inject({}) {|result, key| result.merge(key[0] => key[1], key[0].mb_chars.upcase.to_s => key[1].capitalize)}  

  def transliterated
    self.gsub(/./) do |character|
      TRANSLITERATION_CHARACTERS_MAP[character] || character
    end
  end
end