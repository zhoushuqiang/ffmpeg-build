#!/bin/bash
#suker-2016-0624 add for ffmpeg link thirdparty libs build
#http://ffmpeg.org/download.html
#http://johnvansickle.com/ffmpeg/release-source/

bldmodule()
{
	echo ==================================================build module $1 begin
	cd $1
	./configure --prefix=/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/$1 && make && make install
	cd ../
	echo ==================================================build module $1 end
}


cmakemodule()
{
	echo ==================================================build module $1 begin
	cd $1
	mkdir -p bld &&
	cd bld &&
	cmake -DCMAKE_INSTALL_PREFIX=/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/$1 \
          -DBUILD_SHARED_LIBS=OFF \
   		  ../$2                   &&
	make && make install
	cd ../../
	echo ==================================================build module $1 end
}



#	cmake -DCMAKE_INSTALL_PREFIX=/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/$1 && make && make install

#=========================13:15.18 start
#bldmodule  fdk-aac-0.1.4
#bldmodule  fontconfig-2.11.0
#bldmodule  freetype-2.6.1
#bldmodule  frei0r-plugins-1.4
#bldmodule  lame-3.99.5

#====================================================
#bldmodule  fribidi-0.19.7 #new lib for ass
 #use new source https://ffmpeg.zeranoe.com/builds/source/external_libraries/libass-0.13.2.tar.xz, then ok
#bldmodule  libass-0.13.2      #bldmodule  libass-git
#====================================================
#cmakemodule  libsoxr-git .    #bldmodule  libsoxr-git
#cmakemodule  libvidstab-git .  #bldmodule  libvidstab-git

#====================================================
#bldmodule  libogg-1.3.2
#bldmodule  libvorbis-1.3.4
#====================================================
#bldmodule  libvpx-git #ok
#bldmodule  libwebp-0.4.4
#bldmodule  libx264-git
#cmakemodule  libx265-git source
#bldmodule  opencore-amr-0.1.3
#bldmodule  opus-1.1.1
#bldmodule  speex-1.2rc2
#bldmodule  vo-aacenc-0.1.3
#cmakemodule  vo-amrwbenc-0.1.3

 #use new source https://ffmpeg.zeranoe.com/builds/source/external_libraries/vo-amrwbenc-0.1.3.tar.xz, then ok
#bldmodule  vo-amrwbenc-0.1.3

#https://github.com/lu-zero/mfx_dispatch
#cmakemodule mfx_dispatch-master

#https://github.com/uclouvain/openjpeg
#cmakemodule  openjpeg-master

#http://rtmpdump.mplayerhq.hu/download/
#cmakemodule  rtmpdump
#cd rtmpdump && make && make install

#http://downloads.xiph.org/releases/theora/
#bldmodule  libtheora-1.2.0alpha1


#https://labs.xvid.com/source/#Release
#bldmodule  xvidcore


#https://github.com/sekrit-twc/zimg
#https://sourceforge.net/projects/zimg/
#https://ffmpeg.zeranoe.com/builds/source/external_libraries/zimg-2.0.4.tar.xz
#cmakemodule  zimg-master
#bldmodule    zimg-2.0.4
#=========================13:21:17 end


cd ffmpeg-3.0.2
./configure --prefix=/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/ffmpeg-3.0.2\
 --enable-ffplay \
 --enable-gpl \
 --enable-version3 \
 --enable-static \
 --disable-debug \
 --enable-libmp3lame \
 --enable-libx264 \
 --enable-libx265 \
 --enable-libwebp \
 --enable-libspeex \
 --enable-libvorbis \
 --enable-libvpx \
 --enable-libfreetype \
 --enable-fontconfig \
 --enable-libxvid \
 --enable-libopencore-amrnb \
 --enable-libopencore-amrwb \
 --enable-libtheora \
 --enable-libvo-amrwbenc \
 --enable-gray \
 --enable-libopenjpeg \
 --enable-libopus \
 --enable-libass \
 --enable-libvidstab \
 --enable-libsoxr \
 --enable-frei0r \
 --enable-libfribidi \
 --disable-indev=sndio \
 --disable-outdev=sndio \
 --enable-librtmp \
 --enable-libzimg \
 --extra-cflags="-I/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/install/include" \
 --extra-ldflags="-L/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/install/lib -L/usr/lib/x86_64-linux-gnu/" \
 --extra-libs="-lexpat -lpng -lharfbuzz -lgomp -ldl  -lz -lpthread  -lstdc++ -lm -lrt -lfreetype" \

make && make install



#https://www.freedesktop.org/software/harfbuzz/release/
#undefined reference to `hb_buffer_create'
#libharfbuzz

#undefined reference to `XML_ParserCreate'
#-lexpat 

# undefined reference to `png_create_read_struct'
#-lpng

# --extra-ldflags="-L/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/install/lib -L/usr/lib/gcc/x86_64-linux-gnu/4.8/"\
# --enable-gnutls \
# --enable-libmfx \
# --extra-libs="-lmfx -ldl -lstdc++"

#./configure \
#    --enable-nonfree \
#    --enable-memalign-hack\
#    --enable-faad \
#    --enable-libfaac\
#    --enable-libvo-aacenc\


# --enable-shared \

#http://downloads.xiph.org/releases/ogg/
#https://www.fribidi.org/
#https://ffmpeg.zeranoe.com/builds/source/external_libraries/
#http://www.open-open.com/lib/view/open1431651371544.html
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/fribidi-0.19.7/lib/pkgconfig
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/suker/work/source/johnvansickle.com/ffmpeg/release-source/build/libogg-1.3.2/lib/pkgconfig
#export | grep PKG_CONFIG_PATH

#bldmodule  x264-20160420-git-3b70645 

#bldmodule  libvorbis-1.3.4
#checking for OGG... no
#checking for Ogg... no
#*** Could not run Ogg test program, checking why...
#*** The test program failed to compile or link. See the file config.log for the
#*** exact error that occured. This usually means Ogg was incorrectly installed
#*** or that you have moved Ogg since it was installed.
#configure: error: must have Ogg installed!
#http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz
#	libogg-1.3.2.tar.xz	2014-05-27 19:58	398K	

#export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/root/soft/ffmpeg/lib/pkgconfig:/root/soft/fribidi/lib/pkgconfig"

#wget http://ffmpeg.org/releases/ffmpeg-1.1.3.tar.gz
#tar zxf ffmpeg-1.1.3.tar.gz
#cd ffmpeg-1.1.3
#PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig 

#===============================================================================
#===============================================================================
#===============================================================================
#===============================================================================
#===============================================================================

###http://pkgs.repoforge.org/
#http://www.ffmpeg.org/general.html
#===============================================================================
#https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz/download
#wget     https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz
#curl -L  https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz -o fdk-aac-0.1.4.tar.gz
#-------------------------------------------------------------------------------
#          https://www.freedesktop.org/wiki/Software/fontconfig/
#curl -L   https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.0.tar.bz2  -o  fontconfig-2.12.0.tar.bz2
#--------------------------------------------------------http://www.findeen.co.uk/libvpx_source_code_download.html-----------------------
#ubuntu have::::libfreetype.so.6 => /usr/lib/x86_64-linux-gnu/libfreetype.so.6 (0x00007efd09ce3000)
#https://www.freetype.org/download.html
#http://download.savannah.gnu.org/releases/freetype/
#curl -L   http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.bz2  -o  freetype-2.6.tar.bz2
#http://downloads.sourceforge.net/project/freetype/freetype2/2.6.2/freetype-2.6.2.tar.bz2
#?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Ffreetype%2Ffiles%2F&ts=1466750499&use_mirror=netix
#-------------------------------------------------------------------------------
#https://frei0r.dyne.org/
#https://files.dyne.org/frei0r/
#curl -L   https://files.dyne.org/frei0r/releases/frei0r-plugins-1.5.0.tar.gz  -o  frei0r-plugins-1.5.0.tar.gz
#-------------------------------------------------------------------------------
#http://lame.sourceforge.net/
#curl -L   https://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz  -o  lame-3.99.5.tar.gz
#-------------------------------------------------------------------------------
#curl -L   https://github.com/libass/libass/releases/download/0.13.2/libass-0.13.2.tar.xz  -o  libass-0.13.2.tar.xz
#https://github.com/libass/libass.gitcurl  -L  https://sourceforge.net/projects/opencore-amr/files/vo-aacenc/vo-aacenc-0.1.3.tar.gz  -o  vo-aacenc-0.1.3.tar.gz
#-------------------------------------------------------------------------------
#curl -L   https://sourceforge.net/projects/soxr/files/soxr-0.1.2-Source.tar.xz  -o  soxr-0.1.2-Source.tar.xz
#-------------------------------------------------------------------------------
#http://public.hronopik.de/vid.stab/download.php?lang=en
#https://github.com/georgmartius/vid.stab
#curl -L  https://github.com/georgmartius/vid.stab/tarball/release-0.98b       -o  georgmartius-vid.stab-release-0.98b-0-g3b35b4d.tar.gz
#curl -L  https://github.com/georgmartius/vid.stab/archive/master.zip
#-------------------------------------------------------------------------------
#http://savannah.nongnu.org/projects/liboggpp
#http://www.vorbis.com/
#curl -L  http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz         -o  libogg-1.3.2.tar.xz  
#-------------------------------------------------------------------------------
#curl -L  http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz         -o  libvorbis-1.3.5.tar.xz
#-------------------------------------------------------------------------------
#http://www.theora.org/downloads/
#curl -L  http://downloads.xiph.org/releases/theora/libtheora-1.2.0alpha1.tar.xz  -o  libtheora-1.2.0alpha1.tar.xz
#curl -L  http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2  -o  libtheora-1.1.1.tar.bz2
#-------------------------------------------------------------------------------
#http://downloads.xiph.org/releases/
#-------------------------------------------------------------------------------
#http://www.webmproject.org/code/
#https://github.com/webmproject/libvpx/
#http://www.findeen.co.uk/libvpx_source_code_download.html
#http://www.linuxfromscratch.org/blfs/view/svn/multimedia/libvpx.html
#curl -L  http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2  -o  libvpx-1.5.0.tar.bz2
#-------------------------------------------------------------------------------
#http://www.linuxfromscratch.org/blfs/view/svn/general/libwebp.html
#https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html
#https://developers.google.com/speed/webp/
#curl -L http://downloads.webmproject.org/releases/webp/libwebp-0.5.0.tar.gz  -o  libwebp-0.5.0.tar.gz
#curl -L https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.5.0.tar.gz  -o  libwebp-0.5.0.tar.gz
#./configure --prefix=/usr  --enable-libwebpmux  --enable-libwebpdemux  --enable-libwebpdecoder --enable-libwebpextras  --enable-swap-16bit-csp  --disable-static  && make
#-------------------------------------------------------------------------------
#http://www.videolan.org/developers/x264.html
#git clone http://git.videolan.org/git/x264.git
#curl  -L  ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2  -o  last_x264.tar.bz2
#-------------------------------------------------------------------------------
#http://www.videolan.org/developers/x265.html
#hg clone http://hg.videolan.org/x265
#https://x265.com/
#-------------------------------------------------------------------------------
#https://sourceforge.net/projects/opencore-amr/files/
#https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-0.1.3.tar.gz/download
#curl  -L  https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-0.1.3.tar.gz  -o  opencore-amr-0.1.3.tar.gz
#-------------------------------------------------------------------------------
#curl  -L  https://sourceforge.net/projects/opencore-amr/files/vo-aacenc/vo-aacenc-0.1.3.tar.gz  -o  vo-aacenc-0.1.3.tar.gz
#-------------------------------------------------------------------------------
#curl  -L  https://sourceforge.net/projects/opencore-amr/files/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz  -o  vo-amrwbenc-0.1.3.tar.gz
#-------------------------------------------------------------------------------
#http://www.opus-codec.org/
#curl  -L  http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz  -o  opus-1.1.2.tar.gz
#-------------------------------------------------------------------------------
#http://www.speex.org/
#curl  -L  http://downloads.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz  -o  speexdsp-1.2rc3.tar.gz
#-------------------------------------------------------------------------------
#libmfx
#http://www.freemxf.org/
#http://www.phoronix.com/scan.php?page=news_item&px=Libav-New-Libmfx-Decoders
#https://github.com/lu-zero/mfx_dispatch
#git clone https://github.com/lu-zero/mfx_dispatch.git
#https://www.freedesktop.org/software/vaapi/releases/
#-------------------------------------------------------------------------------
#http://www.openjpeg.org/
#curl  -L  https://github.com/uclouvain/openjpeg/archive/version.2.1.tar.gz  -o  version.2.1.tar.gz
#-------------------------------------------------------------------------------
#http://rtmpdump.mplayerhq.hu/
#curl  -L  https://ffmpeg.zeranoe.com/builds/source/external_libraries/rtmpdump-20151223-git-fa8646d.tar.xz  -o  version.2.1.tar.gz
#-------------------------------------------------------------------------------
#https://www.xvid.com/
#https://labs.xvid.com/source/
#svn checkout http://svn.xvid.org/trunk --username anonymous
#curl  -L  http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.gz  -o  xvidcore-1.3.4.tar.gz
#curl  -L  http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.bz2  -o  xvidcore-1.3.4.tar.bz2
#-------------------------------------------------------------------------------
#https://github.com/buaazp/zimg.git
#curl  -L  https://sourceforge.net/projects/zimg/files/zimg/zimg-5.0.0/zimg-5.0.0.tar.gz  -o  zimg-5.0.0.tar.gz
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

