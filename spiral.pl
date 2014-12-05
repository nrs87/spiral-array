use strict;
use warnings;

=pod
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
=cut

# Print out loop counts while testing
my $debug = 1;

# Test with several example matrices
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

# Create a master hash of all above example tests
my %testCases = (
   $answer1 => \@matrix1,
   $answer2 => \@matrix2,
   $answer3 => \@matrix3,
   $answer4 => \@matrix4,
   $answer5 => \@matrix5,
   $answer6 => \@matrix6,
   $answer7 => \@matrix7,
   $answer8 => \@matrix8
);

while (my ($answer, $matrixRef) = each(%testCases)){
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

      # Traverse through the matrix
      while(($maxMatrix >= $minMatrix)
      && ($maxElement >= $minElement)){
         while($currentElement < $maxElement){
            if($debug){
               print '1M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
               print '1E: ' . $currentElement . "($minElement - $maxElement)\n";
            }

            $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
            $currentElement++;
         } # loop1, horizontal forward

         while($currentMatrix < $maxMatrix){
            if($debug){
               print '2M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
               print '2E: ' . $currentElement . "($minElement - $maxElement)\n";
            }

            $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
            $currentMatrix++;
         } # loop2, vertical forward

         while($currentElement > $minElement){
            if($debug){
               print '3M: ' . $currentMatrix . "($minMatrix - $maxMatrix) ";
               print '3E: ' . $currentElement . "($minElement - $maxElement)\n";
            }

            $currentResult .= $matrix[$currentMatrix][$currentElement] . ' ';
            $currentElement--;
         } # loop3, horizontal backwards

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

# Solution attempt 1
=pod
   # Initialize variables to use in order to traverse matrix
   my $activeRow = 0;
   my $maxAcrossIndex = @{$matrix[0]};
   $maxAcrossIndex--;

   my $activeColumn = @{$matrix[0]};
   $activeColumn--;
   my $maxDownIndex = @matrix;
   $maxDownIndex--;

   # Traverse matrix in a sprial pattern
   while ($maxAcrossIndex > $activeRow){
      # Go across the matrix
      for (my $i = $activeRow; $i <= $maxAcrossIndex; $i++){
         $currentResult .= $matrix[$activeRow][$i] . ' ';
      }
      if($debug){
         $currentResult .= "LOOP1 COMPLETE\n";
      }

      # Go down the elements of the matrix
      for (my $i = ($activeRow+1); $i <= $maxDownIndex; $i++){
         $currentResult .= $matrix[$i][$activeColumn] . ' ';
      }
      if($debug){
         $currentResult .= "LOOP2 COMPLETE\n";
      }

      # Go backwards
      $activeColumn--;
      if(!(($activeColumn == $maxDownIndex)
      && ($activeColumn == $activeRow))){
         for (my $i = $activeColumn; $i >= $activeRow; $i--){
            $currentResult .= $matrix[$maxDownIndex][$i] . ' ';
         }
         if($debug){
            $currentResult .= "LOOP3 COMPLETE\n";
         }
      }

      # Go back up
      $maxDownIndex--;
      for (my $i = $maxDownIndex; $i > $activeRow; $i--){
         $currentResult .= $matrix[$i][$activeRow] . ' ';


         # Special final element
#print 'DINDEX: ' . $maxDownIndex . "\n";
#print 'ROW:    ' . $activeRow . "\n";
#print 'COL:    ' . $activeColumn . "\n";
#print 'AINDEX: ' . $maxAcrossIndex . "\n";
         if(($maxDownIndex == $activeColumn)
         && ($activeColumn == ($activeRow+1))){
            $currentResult .= $matrix[$activeColumn][$maxDownIndex] . ' ';
         }
      }
      if($debug){
         $currentResult .= "LOOP4 COMPLETE\n";
      }

      $activeRow++;
      $maxAcrossIndex--;
   }
=cut

   # *** RESULTS ***
   $currentResult =~ s/\s$//;

   # Now, compare to the associated answer
   print $currentResult . "\n";
   print $answer . "\n";
   if($currentResult eq $answer){
      print '>> PASSED' . "\n\n";
   } else{
      print '>> FAILED' . "\n\n";
   }
} # foreach test case
