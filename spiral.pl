use strict;
use warnings;

=being objective
Assume you have a two dimensional array. Each element will be an integer starting
from 1, at [0][0], and increasing left to right, then top to bottom. For example:

1 2 3 4
5 6 7 8
9 10 11 12
13 14 15 16

Write a program that walks the matrix in a clockwise spiral, starting from [0][0]
and spiraling inward. The output of the program should be the value stored at each
cell of the matrix, in the order of traversal. For the example matrix above, the
correct output of the problem would be:

1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10
=end objective
=cut

# ===========================================================
# DEBUG FLAG
# ===========================================================
my $debug = 0;

# ===========================================================
# FUNCTION: sprialMatrix
# ===========================================================
# PARAMETERS:
# $matrixRef: 2D array reference for the matrix to traverse
#
# RETURN:
# Value stored at each cell of matrix in order of traversal 
# ===========================================================
sub spiralMatrix($){
   my ($matrixRef) = @_;

   # Initialize
   my @matrix = @{$matrixRef};
   my $currentResult = '';

   # Deal with edge cases
   if (scalar(@matrix) == 0){
      # nothing
   } elsif (scalar(@matrix) == 1){
      foreach my $element (@{$matrix[0]}){
         $currentResult = $element . ' ';
      }

   # Traverse the matrix in a spiral pattern
   } else{
      # Initialize boundaries
      my $maxMatrix = scalar(@matrix) - 1;
      my $maxElement = scalar(@{$matrix[0]}) - 1;
      my $minMatrix = 0;
      my $minElement = 0;

      # Set where to start the spiral
      my $currentMatrix = 0;
      my $currentElement = 0;

      # Deal with edge cases
      if($maxElement == 0){
         foreach my $element (@matrix){
            $currentResult .= @{$element}[0] . ' ';
         }

      } else{
         # Traverse through the matrix
         TRAVERSE:
         while(($maxMatrix >= $minMatrix)
         && ($maxElement >= $minElement)){
            # Traverse matrix horizontally, left to right
            while($currentElement < $maxElement){
               if($debug){
                  print '1M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
                  print '1E: ' . $currentElement . "($minElement - $maxElement)\n";
               }

               $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
               $currentElement++;
            } # loop1, horizontal forward

            # Traverse matrix vertically, top to bottom
            while($currentMatrix < $maxMatrix){
               if($debug){
                  print '2M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
                  print '2E: ' . $currentElement . "($minElement - $maxElement)\n";
               }

               $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
               $currentMatrix++;
            } # loop2, vertical forward

            # Error checking
            if($minElement == $maxElement){
               last TRAVERSE;
            }

            # Traverse matrix horizontally, right to left
            while($currentElement > $minElement){
               if($debug){
                  print '3M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
                  print '3E: ' . $currentElement . "($minElement - $maxElement)\n";
               }

               $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
               $currentElement--;
            } # loop3, horizontal backwards

            # Traverse matrix vertically, bottom to top
            $minMatrix++;
            while($currentMatrix > $minMatrix){
               if($debug){
                  print '4M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
                  print '4E: ' . $currentElement . "($minElement - $maxElement)\n";
               }
               
               $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
               $currentMatrix--;
            } # loop4, vertical backwards

            $minElement++;
            $maxElement--;
            $maxMatrix--;
         } # while traversing matrix

         # Print final element, if necessary
         if($debug){
            print 'DM: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
            print 'DE: ' . $currentElement . "($minElement - $maxElement)\n";
         }

         if(($currentMatrix != $currentElement)
         || (($minMatrix == $minElement) && ($maxMatrix == $maxElement))){
            $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
         }
      } # edge case check
   } # edge case check

   # *** RESULTS ***
   $currentResult =~ s/\s$//;
   return $currentResult;
} # sub spiralMatrix

# ===========================================================
# TESTING
# ===========================================================
# Create tests
my @matrix1 = (
[1,2,3,4],
[5,6,7,8],
[9,10,11,12],
[13,14,15,16]
);
my $answer1 = '1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10';

my @matrix2 = (
[ 1, 2, 3, 4, 5, 6, 7, 8],
[ 9,10,11,12,13,14,15,16],
[17,18,19,20,21,22,23,24],
[25,26,27,28,29,30,31,32],
[33,34,35,36,37,38,39,40],
[41,42,43,44,45,46,47,48],
[49,50,51,52,53,54,55,56]
);
my $answer2 = '1 2 3 4 5 6 7 8 16 24 32 40 48 56 55 54 53 52 51 50 49 41 33 25 17 9 10 11 12 13 14 15 23 31 39 47 46 45 44 43 42 34 26 18 19 20 21 22 30 38 37 36 35 27 28 29';

my @matrix3 = (
[ 1, 2, 3, 4, 5],
[ 6, 7, 8, 9,10],
[11,12,13,14,15],
[16,17,18,19,20],
[21,22,23,24,25]
);
my $answer3 = '1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6 7 8 9 14 19 18 17 12 13';

my @matrix4 = (
[ 1, 2, 3, 4, 5, 6, 7],
[ 8, 9,10,11,12,13,14],
[15,16,17,18,19,20,21],
[22,23,24,25,26,27,28]
);
my $answer4 = '1 2 3 4 5 6 7 14 21 28 27 26 25 24 23 22 15 8 9 10 11 12 13 20 19 18 17 16';

my @matrix5 = (
[]
);
my $answer5 = '';

my @matrix6 = (
[1]
);
my $answer6 = '1';

my @matrix7 = (
[ 1, 2],
[ 3, 4]
);
my $answer7 = '1 2 4 3';

my @matrix8 = (
[ 1, 2, 3],
[ 4, 5, 6],
[ 7, 8, 9]
);
my $answer8 = '1 2 3 6 9 8 7 4 5';

my @matrix9 = (
[ 1],
[ 2],
[ 3],
[ 4],
[ 5]
);
my $answer9 = '1 2 3 4 5';

my @matrix10 = (
[ 1, 2, 3],
[ 4, 5, 6],
[ 7, 8, 9],
[10,11,12],
[13,14,15],
[16,17,18],
[19,20,21],
[22,23,24],
[25,26,27]
);
my $answer10 = '1 2 3 6 9 12 15 18 21 24 27 26 25 22 19 16 13 10 7 4 5 8 11 14 17 20 23';

my @matrix11 = (
[ 1, 2, 3, 4, 5, 6, 7, 8, 9],
[10,11,12,13,14,15,16,17,18]
);
my $answer11 = '1 2 3 4 5 6 7 8 9 18 17 16 15 14 13 12 11 10';

# Create a master hash of all above example tests
my %testCases = (
   $answer1 => \@matrix1,
   $answer2 => \@matrix2,
   $answer3 => \@matrix3,
   $answer4 => \@matrix4,
   $answer5 => \@matrix5,
   $answer6 => \@matrix6,
   $answer7 => \@matrix7,
   $answer8 => \@matrix8,
   $answer9 => \@matrix9,
   $answer10 => \@matrix10,
   $answer11 => \@matrix11
);

# Attempt each test, determine if passed or failed
while (my ($answer, $matrixRef) = each(%testCases)){
   my $currentResult = spiralMatrix($matrixRef);

   # Now, compare to the associated answer
   print $currentResult . "\n";
   print $answer . "\n";
   if($currentResult eq $answer){
      print '>> PASSED' . "\n\n";
   } else{
      print '>> FAILED' . "\n\n";
   }
} # foreach test case
