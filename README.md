babelfish : Ruby interface to Yahoo! BabelFish translation service
==================================================================

This is a completely *unofficial* (and incredibly simple) Ruby
interface to the Yahoo! BabelFish translation service.  Enjoy!


Installation
------------

Run the following command to install this library:

    sudo gem install babelfish


Usage:  Command Line
--------------------

Here are some examples of using the command-line interface:

    # echo "Hello world!" | babelfish en es
    ¡Hola mundo!

    # echo "How are you?" > foo.txt
    # babelfish en es foo.txt
    ¿Cómo está usted?

Run `babelfish --help` to see the list of supported languages.


Usage:  Ruby Library
--------------------

Here is an example of using the library in Ruby:

    require 'rubygems'
    require 'babelfish'

    input_text = "I am well, thank you."
    input_code = "en"

    puts input_text
    BabelFish::LANGUAGE_PAIRS[input_code].each do |output_code|
      print "  in #{BabelFish::LANGUAGE_NAMES[output_code]} is: "
      puts BabelFish.translate(input_text, input_code, output_code)
    end

The result of running the above example is:

    I am well, thank you.
      in Italian is: Sono bene, grazie.
      in Japanese is: 私は元気でいる、ありがとう。
      in German is: Ich fÃehle mich gut, danke.
      in French is: Je vais bien, merci.
      in Spanish is: Estoy bien, gracias.
      in Russian is: Я наилучшим образом, вы.
      in Chinese-simp is: 我很好，谢谢。
      in Portuguese is: Eu sou bem, obrigado.
      in Korean is: 나는 잘 있다, 당신을 감사하십시오.
      in Chinese-trad is: 
      in Greek is: Είμαι καλά, σας ευχαριστώ.
      in Dutch is: Ik ben goed, dank u.

Read the [RDoc documentation](api/index.html) for more information.


License
-------

Copyright 2007 Suraj N. Kurapati <sunaku@gmail.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


* * *

Visit [http://snk.tuxfamily.org/lib/babelfish/]() for more information.
