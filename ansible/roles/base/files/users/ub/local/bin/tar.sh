#!/bin/sh

#https://stackoverflow.com/questions/18855850/create-a-tar-xz-in-one-command/18855909#18855909
#https://linuxreviews.org/Comparison_of_Compression_Algorithms

### Piped
### !preferred way 
### xz specific:
### -0e ==>> -compession_level --extreme 
### -T0 ==>> max cpu threads 
### -k, --keep ==>> keep the original file 
##tar -cf - directory/ | xz -z -0 -T0  - > directory.tar.xz

tarxz() { tar cf - "$1" | xz -4e > "$1".tar.xz ; }
tarxz name_of_directory

### decompress
xz -dc filename.tar.xz | tar x



### Combined
### compress to xz
### -J ==>> xz archiver
### OR use -a,--auto-compress with newer tar versions 
#XZ_OPT="-9e -T0" tar -cJf <archive.tar.xz> <files>


### minimum
### compress
## tar c some-dir | xz > some-dir.tar.xz
## tar c some-dir | gzip > some-dir.tar.gz
## tar c some-dir | bzip2 > some-dir.tar.bz2
### decompress 
## xzcat tarball.tar.xz | tar x
## bzcat tarball.tar.bz2 | tar x
## zcat tarball.tar.gz | tar x
## cat archive.tar | tar x

