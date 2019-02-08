module Questioning

  def question_1
    puts "How many states in the US?:"
    puts "A) 52"
    puts "B) 25"
    puts "C) 16"
  end

  def question_2
    puts "How many kings has the UK had?"
    puts "A) 21"
    puts "B) 35"
    puts "C) 80"
  end
  
  def question_3
    puts "What colour do you get when mixing black and white?"
    puts "A) grey"
    puts "B) pink"
    puts "C) blue"
  end
   
end


module Answering

#@choices = (:A..:C).to_a
#go = choice.sort_by {rand}.each_slice(3).map {|x| x.zip(answer)}

#lets no shuffle for now

 def answer_1
   correct = "52"
   wrong = "25"
   wrong = "16"
   answers = {"A" => correct, "B" => wrong, "C" => wrong}
 end

 def answer_2
   correct = "35"
   wrong = "21"
   wrong = "80"
   answers = {"A" => wrong, "B" => correct, "C" => wrong}
 end

  def answer_3
   correct = "grey"
   wrong = "pink"
   wrong = "blue"
 end

end


class Questions

  include Questioning

  def give_me_an_answer
    puts "Please turn caps lock ON! Please chose either A, B or C"
    answer = gets.chomp
  end

end

class Answers
  attr_accessor :counter
  attr_reader   :incorrect_answers, :correct_answers
  
  include Answering

  def initialize(arg)
    self.counter = 1
    @quizz_master = arg
  end

  def incorrect_answers
    @incorrect_tally ||= []
  end

  def correct_answers
    @correct_tally ||= []
  end

  def final(arg)
    if arg == "52"
      puts "Well Done!!!"
      correct_answers.insert(-1, "tick")
    else
      puts "Nevermind, lets move on"
      incorrect_answers.insert(-1, "tick")
    end
    self.counter += 1
    self.answer_call(self.counter)
  end

  def match_with_correct
    pass_up = self.answer_1["#{@answer}"]
    self.final(pass_up)
  end

  def answer_call(arg)
    meth = Questions.instance_methods.select{|x| x[-1] == "#{arg}"}
    if meth.empty?
      puts "game over, no more questions"
      puts "you scored #{self.incorrect_answers.size} incorrect answers"
      puts "you scored #{self.correct_answers.size} correct_answers"
    else
      @quizz_master.send(meth[0])
      @answer = @quizz_master.give_me_an_answer
      if @answer
        self.match_with_correct
      else
        exit
      end
    end
  end

end

game = Answers.new(Questions.new)
game.answer_call(1)