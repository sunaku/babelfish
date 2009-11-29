require 'open-uri'
require 'net/http'
require 'uri'
require 'set'

require 'rubygems'
require 'hpricot'

# Ruby interface to Yahoo! BabelFish translation service.
module BabelFish
  ##
  # project information
  #

  PROJECT = 'babelfish'
  VERSION = '0.0.1'
  RELEASE = '2008-12-30'
  WEBSITE = "http://snk.tuxfamily.org/lib/#{PROJECT}"
  SUMMARY = 'Ruby interface to Yahoo! BabelFish translation service.'
  DISPLAY = PROJECT + ' ' + VERSION
  INSTALL = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  ##
  # service connection
  #

  # the URI through which the translation service is accessed
  SERVICE_URI = URI.parse('http://babelfish.yahoo.com/translate_txt')

  # Provides access to a language's name when given a language code.
  LANGUAGE_NAMES = {} # code => name

  # Provides access to a list of destination language codes when
  # given a source language code.  In other words, this hash tells
  # you the possible translations that are supported by the service.
  LANGUAGE_PAIRS = Hash.new {|h,k| h[k] = Set.new } # code => [code]

  # determine what translations are supported by the service
  open(SERVICE_URI).read.
  scan(/<option\s+value="(\w+)_(\w+)">(.*?)\s+to\s+(.*?)</).
  each do |src_code, dst_code, src_name, dst_name|
    LANGUAGE_NAMES[src_code] = src_name
    LANGUAGE_NAMES[dst_code] = dst_name

    LANGUAGE_PAIRS[src_code] << dst_code
  end

  # A list of possible language codes supported by the service.
  LANGUAGE_CODES = LANGUAGE_PAIRS.keys

  ##
  # service interface
  #

  # Translates the given input from the given source
  # language into the given destination language.
  #
  # input_text::        the text you want to translate
  # input_lang_code::   the code of the language in
  #                     which the input text is written
  # output_lang_code::  language code of the result of translation
  # output_encoding::   desired encoding of the result of translation
  #
  def BabelFish.translate input_text, input_lang_code, output_lang_code, output_encoding = 'utf-8'
    output_page = Net::HTTP.post_form(
      SERVICE_URI,
      :eo => output_encoding,
      :lp => "#{input_lang_code}_#{output_lang_code}",
      :trtext => input_text.to_s
    )

    doc = Hpricot(output_page.body)
    res = (doc / '#result' / 'div').inner_html

    if res.respond_to? :encoding
      res = eval(
        "# encoding: #{output_encoding}\n#{res.inspect}",
        TOPLEVEL_BINDING, __FILE__, __LINE__
      )
    end

    res
  end
end
