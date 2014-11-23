SQL
===

It will return a list of the users with the highest number of overall retweets (calculated as the sum of all of the retweets for every tweet a user has posted), along the number of total tweets that user has posted. This list will have three columns: the username, the total number of retweets and the total number of tweets. This data could be used to determine the most popular users on Twitter, as well as figure out which users have the most retweets per tweet (a ratio). As a sidenote, this SQL query is inefficient because it retrieves the tweet text in the first sub-query, and this is unnecessary.

Pseudocode for map reduce
=========================

In Haskell:

    module MapReduce where

    import Data.List (sortBy)

    count :: a -> (a, Int)
    count x = (x, 1)

    sort :: (Ord a) => [(a, b)] -> [(a, b)]
    sort = sortBy (\a b -> compare (fst a) (fst b))

    group :: (Eq a) => [(a, b)] -> [[(a, b)]]
    group = groupBy (\a b -> fst a == fst b)

    reduce :: [(a, Int)] -> (a, Int)
    reduce list = (fst $ head list, foldr (\x count -> count + snd x) 0 list)

    result xs = map reduce $ group $ sort $ map count xs

Note: in this code, `count` is the mapping function. I use the Haskell builtin `map` to apply it to every input.

At what size does hadoop make a difference
==========================================

Hadoop only starts to make a difference when the input dataset is too large to be processed in a reasonable amount of time by a personal computer. In my case, I'll define "reasonable amount of time" as "less than one hour on a laptop". For the purposes of this specific question, let's benchmark the performance of my MapReduce program written in Haskell when used to compute the word count of Moby Dick on my laptop. First, I'll show the code I used:

    module Main where

    import MapReduce
    import System.IO
    import Data.Char
    import Data.List (sortBy)

    clean :: String -> String
    clean s = [toLower c | c <- s, isAlpha c]

    main = do
        print "Reading file..."
        contents <- readFile "mobydick.txt"
        let w = map clean $ words contents

        print "Map-reducing..."
        let res = reverse $ sortBy (\a b -> compare (snd a) (snd b)) $ result w

        print "Writing..."
        writeFile "mobydick-out.txt" $ show res

        print "Done."

And the benchmark:

    ╭─jdiez@voidray  ~/uni/220ct/week6
    ╰─$ time ./q3
    "Reading file..."
    "Map-reducing..."
    "Writing..."
    "Done."
    ./q3  3.79s user 0.07s system 100% cpu 3.854 total

So it takes ~4 seconds to process the 218633 words in Moby Dick. It has a size of 1.2 megabytes. Therefore my code is processing 0.3 megabytes of data per second. For it to take an hour to process, the input dataset would have to be 1 GB (60 minutes * 60 seconds * 0.3 MB/s ~= 1 GB). While one can use Hadoop for any dataset, the overhead of using it will not be worth it for a dataset below 1 GB.

Of course, the "reasonable amount of time" is defined by the context, so there's no single valid answer. An additional constraint is the resources: if the input dataset does not fit on a single computer, we must use a distributed solution (like Hadoop).


