/*
    Joseph Weizenbaum's classic ELIZA chat bot in Swift.
    Based on the IBM PC BASIC program from CREATIVE COMPUTING by Patricia
    Danielson and Paul Hashfield, the Java adaptation by Jesper Juul, and work by Matthijs Hollemans Hollance.
    Modified for XCode as a question/chat bot by Jason Schneider.

    Press Ctrl-C or Ctrl-D to quit. (Or type "shut up".)
 */

import Foundation

let keywords = [
  "CAN YOU ",
  "CAN I ",
  "YOU ARE ",
  "YOU'RE ",
  "I DON'T ",
  "I FEEL ",
  "WHY DON'T YOU ",
  "WHY CAN'T I ",
  "ARE YOU ",
  "I CAN'T ",
  "I AM ",
  "I'M ",
  "YOU ",
  "I WANT ",
  "WHAT ",
  "HOW ",
  "WHO ",
  "WHERE ",
  "WHEN ",
  "WHY ",
  "NAME ",
  "CAUSE ",
  "SORRY ",
  "DREAM ",
  "HELLO ",
  "HI ",
  "MAYBE ",
  "NO ",
  "YOUR ",
  "ALWAYS ",
  "THINK ",
  "ALIKE ",
  "YES ",
  "FRIEND ",
  "COMPUTER ",
  "NOKEYFOUND",  // no keyword found
  "SHUT UP",       // quit the chat
    " DREAM",
    " DREAM ",
    "DREAMS ",
    " DREAMS",
    " DREAMS ",
    " FRIEND",
    " FRIEND ",
    " FRIENDS",
    "FRIENDS ",
    " FRIENDS ",
    " COMPUTER",
    " COMPUTER ",
    "COMPUTERS ",
    " COMPUTERS",
    " COMPUTERS ",
]

let conjugations = [
    " ARE "  : " AM ",
    " WERE " : " WAS ",
    "YOU "  : "I ",
    " YOUR " : " MY ",
    "YOUR " : "MY ",
    " I'VE " : " YOU'VE ",
    " I'M "  : " YOU'RE ",
    " ME "   : " YOU ",
    " YOU WOULD " : " I'D ",
    " YOU HAVE " : " I'VE ",
    " YOU WILL " : " I'LL ",
    " MY " : " YOUR ",
    " YOU'VE " : " I HAVE ",
    " YOU'LL " : " I WILL ",
    " YOURS " : " MINE ",
    " YOU " : " ME ",
    " I " : " YOU ",
]

let replies = [
    "DON'T YOU BELIEVE THAT I CAN*",
    "PERHAPS YOU WOULD LIKE TO BE LIKE ME*",
    "YOU WANT ME TO BE ABLE TO*",
    "PERHAPS YOU DON'T WANT TO*",
    "DO YOU WANT TO BE ABLE TO*",
    "WHAT MAKES YOU THINK I AM*",
    "DOES IT PLEASE YOU TO BELIEVE I AM*",
    "PERHAPS YOU WOULD LIKE TO BE*",
    "DO YOU SOMETIMES WISH YOU WERE*",
    "DON'T YOU REALLY*",
    "WHY DON'T YOU*",
    "DO YOU WISH TO BE ABLE TO*",
    "DOES THAT TROUBLE YOU*",
    "DO YOU OFTEN FEEL*",
    "DO YOU OFTEN FEEL*",
    "DO YOU ENJOY FEELING*",
    "DO YOU REALLY BELIEVE I DON'T*",
    "PERHAPS IN GOOD TIME I WILL*",
    "DO YOU WANT ME TO*",
    "DO YOU THINK YOU SHOULD BE ABLE TO*",
    "WHY CAN'T YOU*",
    "WHY ARE YOU INTERESTED IN WHETHER OR NOT I AM*",
    "WOULD YOU PREFER IF I WERE NOT*",
    "PERHAPS IN YOUR FANTASIES I AM*",
    "HOW DO YOU KNOW YOU CAN'T*",
    "HAVE YOU TRIED?",
    "PERHAPS YOU CAN NOW*",
    "DID YOU COME TO ME BECAUSE YOU ARE*",
    "HOW LONG HAVE YOU BEEN*",
    "DO YOU BELIEVE IT IS NORMAL TO BE*",
    "DO YOU ENJOY BEING*",
    "WE WERE DISCUSSING YOU--NOT ME.",
    "OH, I*",
    "YOU'RE NOT REALLY TALKING ABOUT ME, ARE YOU?",
    "WHAT WOULD IT MEAN TO YOU IF YOU GOT*",
    "WHY DO YOU WANT*",
    "SUPPOSE YOU SOON GOT*",
    "WHAT IF YOU NEVER GOT*",
    "I SOMETIMES ALSO WANT*",
    "WHY DO YOU ASK?",
    "DOES THAT QUESTION INTEREST YOU?",
    "WHAT ANSWER WOULD PLEASE YOU THE MOST?",
    "WHAT DO YOU THINK?",
    "ARE SUCH QUESTIONS ON YOUR MIND OFTEN?",
    "WHAT IS IT THAT YOU REALLY WANT TO KNOW?",
    "HAVE YOU ASKED ANYONE ELSE?",
    "HAVE YOU ASKED SUCH QUESTIONS BEFORE?",
    "WHAT ELSE COMES TO MIND WHEN YOU ASK THAT?",
    "NAMES DON'T INTEREST ME.",
    "I DON'T CARE ABOUT NAMES --PLEASE GO ON.",
    "IS THAT THE REAL REASON?",
    "DON'T ANY OTHER REASONS COME TO MIND?",
    "DOES THAT REASON EXPLAIN ANYTHING ELSE?",
    "WHAT OTHER REASONS MIGHT THERE BE?",
    "PLEASE DON'T APOLOGIZE!",
    "APOLOGIES ARE NOT NECESSARY.",
    "WHAT FEELINGS DO YOU HAVE WHEN YOU APOLOGIZE?",
    "DON'T BE SO DEFENSIVE!",
    "WHAT DOES THAT DREAM SUGGEST TO YOU?",
    "DO YOU DREAM OFTEN?",
    "WHAT PERSONS APPEAR IN YOUR DREAMS?",
    "ARE YOU DISTURBED BY YOUR DREAMS?",
    "HOW DO YOU DO ...PLEASE STATE YOUR PROBLEM.",
    "YOU DON'T SEEM QUITE CERTAIN.",
    "WHY THE UNCERTAIN TONE?",
    "CAN'T YOU BE MORE POSITIVE?",
    "YOU AREN'T SURE?",
    "DON'T YOU KNOW?",
    "ARE YOU SAYING NO JUST TO BE NEGATIVE?",
    "YOU ARE BEING A BIT NEGATIVE.",
    "WHY NOT?",
    "ARE YOU SURE?",
    "WHY NO?",
    "WHY ARE YOU CONCERNED ABOUT MY*",
    "WHAT ABOUT YOUR OWN*",
    "CAN YOU THINK OF A SPECIFIC EXAMPLE?",
    "WHEN?",
    "WHAT ARE YOU THINKING OF?",
    "REALLY, ALWAYS?",
    "DO YOU REALLY THINK SO?",
    "BUT YOU ARE NOT SURE YOU*",
    "DO YOU DOUBT YOU*",
    "IN WHAT WAY?",
    "WHAT RESEMBLANCE DO YOU SEE?",
    "WHAT DOES THE SIMILARITY SUGGEST TO YOU?",
    "WHAT OTHER CONNECTIONS DO YOU SEE?",
    "COULD THERE REALLY BE SOME CONNECTION?",
    "HOW?",
    "YOU SEEM QUITE POSITIVE.",
    "ARE YOU SURE?",
    "I SEE.",
    "I UNDERSTAND.",
    "WHY DO YOU BRING UP THE TOPIC OF FRIENDS?",
    "DO YOUR FRIENDS WORRY YOU?",
    "DO YOUR FRIENDS PICK ON YOU?",
    "ARE YOU SURE YOU HAVE ANY FRIENDS?",
    "DO YOU IMPOSE ON YOUR FRIENDS?",
    "PERHAPS YOUR LOVE FOR FRIENDS WORRIES YOU.",
    "DO COMPUTERS WORRY YOU?",
    "ARE YOU TALKING ABOUT ME IN PARTICULAR?",
    "ARE YOU FRIGHTENED BY MACHINES?",
    "WHY DO YOU MENTION COMPUTERS?",
    "WHAT DO YOU THINK MACHINES HAVE TO DO WITH YOUR PROBLEM?",
    "DON'T YOU THINK COMPUTERS CAN HELP PEOPLE?",
    "WHAT IS IT ABOUT MACHINES THAT WORRIES YOU?",
    "SAY, DO YOU HAVE ANY PSYCHOLOGICAL PROBLEMS?",
    "WHAT DOES THAT SUGGEST TO YOU?",
    "I SEE.",
    "I'M NOT SURE I UNDERSTAND YOU FULLY.",
    "COME COME ELUCIDATE YOUR THOUGHTS.",
    "CAN YOU ELABORATE ON THAT?",
    "THAT IS QUITE INTERESTING.",
]

/* This table lists the possible replies for each keyword. Each 3-element array
   [a, b, c] consists of: a) the current index in replies array, b) start index
   in the replies array, c) the number of replies for each keyword. */
var replyLookup = [
    [ 0, 0, 3, ],      // keyword 0 has replies 0, 1, and 2
    [ 3, 3, 2, ],      // keyword 1 has replies 3 and 4
    [ 5, 5, 4, ],      // keyword 2 has replies 5, 6, 7, and 8
    [ 5, 5, 4, ],      // and so on...
    [ 9, 9, 4, ],
    [ 13, 13, 3, ],
    [ 16, 16, 3, ],
    [ 19, 19, 2, ],
    [ 21, 21, 3, ],
    [ 24, 24, 3, ],
    [ 27, 27, 4, ],
    [ 27, 27, 4, ],
    [ 31, 31, 3, ],
    [ 34, 34, 5, ],
    [ 39, 39, 9, ],
    [ 39, 39, 9, ],
    [ 39, 39, 9, ],
    [ 39, 39, 9, ],
    [ 39, 39, 9, ],
    [ 39, 39, 9, ],
    [ 48, 48, 2, ],
    [ 50, 50, 4, ],
    [ 54, 54 ,4, ],
    [ 58, 58, 4, ],
    [ 62, 62, 1, ],
    [ 62, 62, 1, ],
    [ 63, 63, 5, ],
    [ 68, 68, 5, ],
    [ 73, 73, 2, ],
    [ 75, 75, 4, ],
    [ 79, 79, 3, ],
    [ 82, 82, 7, ],
    [ 89, 89, 3, ],
    [ 92, 92, 6, ],
    [ 98, 98, 7, ],
    [ 105, 105, 6, ], // NOKEYFOUND
    [ -1, -1, -1, ],  // SHUT
    [ 58, 58, 4,],
    [ 58, 58, 4,],
    [ 58, 58, 4,],
    [ 58, 58, 4,],
    [ 58, 58, 4,],
    [ 92, 92, 6,],
    [ 92, 92, 6,],
    [ 92, 92, 6,],
    [ 92, 92, 6,],
    [ 92, 92, 6,],
    [ 98, 98, 7,],
    [ 98, 98, 7,],
    [ 98, 98, 7,],
    [ 98, 98, 7,],
    [ 98, 98, 7,],
]

func findKeyword(in input: String) -> (index: Int, range: Range<String.Index>)? {
  for (index, keyword) in keywords.enumerated() {
    if let range = input.range(of: keyword) {
      return (index, range)
    }
  }
  return nil
}

extension String {
    func conjugated() -> String {
        // Add spaces around the text so we can match with the conjugations.
        var result = " \(self) "

        // Swap "ARE" for "AM" and "AM" for "ARE", and so on.
        for (conj1, conj2) in conjugations {
            if result.range(of: conj1) != nil {
                result = result.replacingOccurrences(of: conj1, with: conj2)
            } else {  // try swapping the other way around
                result = result.replacingOccurrences(of: conj2, with: conj1)
            }
        }
        return result
    }
}

func nextReply(for index: Int) -> String {
  let reply = replies[replyLookup[index][0]]

  // Move the reply index ahead, and wrap around when we get to the end.
  replyLookup[index][0] += 1
  if replyLookup[index][0] == replyLookup[index][1] + replyLookup[index][2] {
    replyLookup[index][0] = replyLookup[index][1]
  }

  return reply
}

var lastLine = ""
var shouldQuit = false

func parse(_ text: String) -> String {
  // Convert to uppercase and add spaces in order to match keywords.
  let input = " \(text.uppercased()) "

  // This chatbot is a bit of a jerk...
  if input == lastLine {
    return "PLEASE DON'T REPEAT YOURSELF!"
  }
  lastLine = input

  var remainder = ""
  var k = 35          // nothing found
  // Find keyword in the input.
    print(input)
  if let (index, range) = findKeyword(in: input) {

    if index == 36 {     // SHUT
        shouldQuit = true
        return "O.K. IF YOU FEEL THAT WAY I'LL SHUT UP...."
    }

    // Take the remainder of the input string after the keyword and
    // convert "I AM" to "YOU ARE", and so on.
    remainder = String(input[range.upperBound...])
                       .conjugated()
                       .trimmingCharacters(in: .whitespaces)
                       .replacingOccurrences(of: "!", with: "")
    print(remainder)
    k = index
  }

  // Use the keyword index to get a reply.
  let reply = nextReply(for: k)

  // This reply does not have a placeholder so return it verbatim.
  if !reply.hasSuffix("*") {
    return reply
  }

  // The reply has a placeholder but we have nothing to fill into it.
  if remainder.isEmpty{
    return "YOU WILL HAVE TO ELABORATE MORE FOR ME TO HELP YOU."
  }

  return reply.replacingOccurrences(of: "*", with: " " + remainder)
}

func listen(answer: String?) -> String {
    if let text = answer {
    return text.trimmingCharacters(in: .whitespaces)
  } else {
    return "SHUT UP"  // EOF (Ctrl-D)
  }
}

struct MyQuestionAnswerer {
    func responseTo(question: String) -> String {

        var response: String = ""
        let input = listen(answer: question)
        if !input.isEmpty {
            response = parse(input)
            if shouldQuit {
                //delay exiting the program
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                exit(0) }
            }
        }
        return String(response)
    }
}

