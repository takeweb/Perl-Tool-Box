use strict;
use warnings;
use strict;
use warnings;
use File::Path 'rmtree';

#unlink qq{D:\ooishi\tmp};
#unlink qq{C:\Users\taketomoooishi\Downloads};
#unlink qq{C:\$Recycle.Bin};
#unlink qq{D:\$RECYCLE.BIN};

my @list;
my @list1 = glob(q{D:\ooishi\tmp\*});
my @list2 = glob(q{C:\Users\taketomoooishi\Downloads\*});

push(@list, @list1);
push(@list, @list2);

foreach my $file (@list) {
    print "$file\n";
}

rmtree(@list,1,1);

