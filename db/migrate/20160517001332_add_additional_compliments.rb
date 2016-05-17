class AddAdditionalCompliments < ActiveRecord::Migration[5.0]
  def up
    compliments.each do |compliment|
      Compliment.create!(
        body: compliment
      )
    end
  end

  private

    def compliments
      [
        "Your eyebrows are on fleek.",
        "I like your outfit so much that if I wore it on the same day as you I wouldn’t even be embarrassed, we’d just be that stylish.",
        "You’re a great person to do a group project with.",
        "Being alone is kind of nice. Being alone with you is better.",
        "You’re always on time to things, which is awesome because I’m not.",
        "Looking like a complete idiot with you is really fun.",
        "I would hang out with you even if you hadn’t showered for a couple days.",
        "I would be really okay with you seeing me without makeup, that’s how much I like you.",
        "You’re one of my favorite drunken karaoke partners.",
        "You’re really smart, and I’m not just saying that because I want you in my study group.",
        "You have really good taste in friends (i.e. me).",
        "You have a really contagious laugh. See, now I’m laughing and it's all your fault.",
        "Your sense of humor is exactly like mine.",
        "You can pull off wildly colored hair and that is a seriously awesome quality.",
        "I bet that sometimes you actually wake up flawless.",
        "You actually have a lot of interesting things to say, and I don’t say that about just anyone.",
        "You’re so hot, you make a dragon want to retire.",
        "I would go on an 18 hour road trip with you, I like you that much.",
        "Out of all the strangers I meet on a daily basis, I’m glad you’re one of those strangers that became my friend.",
        "If you were running for president, I would vote for you.",
        "If you cooked something really gross, I like you enough that I would tell you instead of politely eating it and hating everything.",
        "You just look really friendly, can we be friends?",
        "I would be really okay with just sitting and watching Netflix with you. Nothing else, just that and it would still be really nice.",
        "If you got really famous, I would be the first member of your fan club.",
        "Things Girls Hear When You Cat-Call At Them",
        "Everyone at sleepovers thought you were the bravest during thunderstorms.",
        "You could make up a weird religion or diet and everyone would follow it.",
        "At least two friends are going to name their child and/or goldfish after you.",
        "You never forget to fill the ice-cube tray.",
        "People always think your jeggings are regular jeans.",
        "You rarely have to go to the bathroom when you fly in the window seat.",
        "You are your parent's greatest accomplishment, unless they invented the 'spork'.",
        "Coworkers fantasize about getting stuck in the elevator with you.",
        "Sushi chefs are wowed by your chopstick dexterity.",
        "Strangers all wanna sit next to you on the bus.",
        "You could open that jar of mayonnaise using only 3 fingers.",
        "Your siblings are pissed that your photo is the star of your parent's mantle.",
        "Your roommate wants a lock of your hair but is afraid to ask.",
        "You remind everyone of kiwis- delicious and surprisingly fuzzy.",
        "A 3rd tier cable network would totally create a television show about you.",
        "80% of motorcycle gangs think you’d be a delightful sidecar.",
        "Cops admire your ability to stay a perfect 3-5 miles above the speed limit.",
        "Your handshake conveys intelligence, confidence and minor claminess.",
        "I’d give you the last piece of my gum even if I’d just ate garlic.",
        "socks + sandals + you = I'm into it.",
        "Kids think you are the 'cool old person'.",
        "Your principal would call you to the office just to look cool.",
        "You are someone's \"the one that got away\".",
        "The FBI tapped your phone just to hear the sound of your voice.",
        "Your parents argue over which one of them you look like.",
        "Cockroaches, mice and other pests avoid your place out of respect."
      ]
    end
end
