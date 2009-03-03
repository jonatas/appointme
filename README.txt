= appointme
  Appointme is a simple schedule in natural language. With this, you can put your appointments in your schedule simply typing what you will do and when you will do it.
  It's my first experience with BDD practices and today I'm very happy because rspec runs ok! I'm driving this project with specs. 

* appointme.rubyforge.org

== DESCRIPTION:

== FEATURES/PROBLEMS:

* my first challenge here:
   - how can i keep this project DRY(Don't repeat yourself)?
     #=> an example for it about time and date:
       I can speak about hours a lot of tips like:
          at num, afternum, 3 o'clock, 02:00 AM, etc.

       on the date:
         today, yesterday, 3 years ago, 2 weeks, this week, etc.

       I'm using chronic for solve this problem.

     Chronic is a good gem and works well. It works with a simple pattern implementing for the words with some tokens recognized.
     There are some classes understanding about time, weeks, months, hours and other stuff like that. And each word should recognize or not for some classes, puting in future or past context, by default it runs with future context.
     Passing by several filters in each word, example:
# normalize string parameter 
# split the phrase and return a array of tokens. 
# scan all words and get base of tokens for each word.
# select all tagged words

it runs well but I knew that can't return non tagged words 
because on the code I found 

@tokens = @tokens.select{|word| workd.tagged?}

and in this line I found what I didn't want, because put a new appointment
is divided by 2 parts time and description, and when I put some phrase like:
"i will go to the dentist tomorrow at 3"
I have 3 words with time and other words should be the description for appointment.
Of course I change this line:

@tokens = @tokens.select{|token| token.tagged?}

to:

@tokens, @non_tagged_tokens = @tokens.partition { |token| token.tagged? }

and with this I know that @non_tagged_tokens should be some array with words that shouldn't have time and is this the description for my appointment.
It's really awesome now and because this I left Osiris chatterbot implementation and I intend to just parse some words to see and erase some time in my schedule.
Solving my problem there's
   Appointme.get_time_and_rest_from("i will go there next monday at 3")
   #=> [Mon Oct 27 15:00:00 -0200 2008, "i will go there"]

== SYNOPSIS:

 try on console:
 script/console
 Appointme.understand("I will go dentist today at 4")  &&  Appointme.understand("tomorrow i need to call my teacher at noon")
 # => "ok"
 >> puts Appointme.understand "show"
 when?: Saturday(18) at 16:00 - i will go dentist
 when?: Sunday(19) at 12:00 - i need to call my teacher num

 
== REQUIREMENTS:

* FIX (list of requirements)

== INSTALL:
  "download this gem here":http://FIXTHISADDRESSESPLEASE
  sudo gem install appointme.gem

* FIX (sudo gem install, anything else)

== LICENSE:

(The MIT License)

Copyright (c) 2008 Jônatas Davi Paganini

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
