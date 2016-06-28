#!/bin/bash

#suker-2016-0624 add for ffmpeg link thirdparty libs build

#http://ffmpeg.org/download.html
#http://www.ffmpeg.org/general.html
#http://johnvansickle.com/ffmpeg/release-source/
#https://ffmpeg.zeranoe.com/builds/
#http://pkgs.repoforge.org/
#http://www.slackware.com/~alien/slackbuilds/ffmpeg/build/
#http://www.linuxfromscratch.org/blfs/view/svn/general/libtasn1.html
#http://www.lysator.liu.se/~nisse/archive/

length=0
SETUP_PATH=`echo $PWD`/build

ISNETGET=$1
ISCLEAN=$2

echo "get new from net true:$1, clean all:$2, setuppath=$SETUP_PATH"

OGGDIR=""

bldmodule()
{
	echo "==================================================build module $1 begin"
	cd $1
	make clean
	echo "./configure --prefix=$SETUP_PATH/$1 $2 $3 $4   --enable-shared --enable-static && make && make install"
	./configure --prefix=$SETUP_PATH/$1 $2 $3 $4  && make && make install
	cd ../
	echo "==================================================build module $1 end"
}

cmakemodule()
{
	echo ==================================================build module $1 begin
	cd $1
	mkdir -p bld &&
	cd bld &&
	make clean
	cmake -DCMAKE_INSTALL_PREFIX=$SETUP_PATH/$1 \
          -DBUILD_SHARED_LIBS=OFF \
   		  ../$2  && make && make install
	cd ../../
	echo ==================================================build module $1 end
}

comnbld()
{
	localname=`echo $1 | awk -F "/" '{print $NF}'`
	length=`expr $length + 1`
	echo "$PWD, index:$length, ========curl get source:$1"

	curl -L  $1 -o $localname

	if [[ $1 =~ "tar.gz" ]]; then
#		echo "\$1 contains tar.gz"
		tar -zxf $localname
	elif [[ $1 =~ "tar.bz2" ]]; then
#		echo "\$1 contains tar.bz2"
		tar -jxf $localname
	elif [[ $1 =~ "tar.xz" ]]; then
#		echo "\$1 contains tar.xz"
		tar -Jxf $localname
	elif [[ $1 =~ "zip" ]]; then
#		echo "\$1 contains zip"
		unzip $localname
	fi


	if [[ $1 =~ "libogg" ]]; then
		echo "\$1 contains libogg"
		OGGDIR=$localname
	fi

	OGGDIR=libogg-1.3.2
	echo "========================oggdir:$OGGDIR"
	
	dirname=`echo $localname | awk -F ".tar" '{print $1}'`
	echo "=================dir-name:$dirname"

	if [[ $2 == 1 ]]; then
		time  bldmodule $dirname
	elif  [[ $2 == 2 ]]; then
		echo "============use cmake mode"
		time  cmakemodule $dirname
	elif  [[ $2 == 3 ]]; then
		echo "============libogg dependence mode"
		time  bldmodule $dirname  --with-ogg=$SETUP_PATH/$OGGDIR
	elif  [[ $2 == 4 ]]; then
		echo "============vidstab compile mode"
		time  cmakemodule georgmartius-vid.stab-3b35b4d
	elif  [[ $2 == 5 ]]; then
		echo "============openjpeg compile mode"
		time  cmakemodule openjpeg-version.2.1
	elif  [[ $2 == 6 ]]; then
		echo "============x264 compile mode"
		X264DIR=x264-snapshot-20160623-2245
		time  bldmodule $X264DIR
		mkdir -p $SETUP_PATH/$X264DIR/lib/
		mkdir -p $SETUP_PATH/$X264DIR/include/
		cp $X264DIR/libx264.a        $SETUP_PATH/$X264DIR/lib/
		cp $X264DIR/x264.h           $SETUP_PATH/$X264DIR/include/
		cp $X264DIR/x264_config.h    $SETUP_PATH/$X264DIR/include/
	elif  [[ $2 == 7 ]]; then
		echo "============xvidcord compile mode"
		XVIDCOREDIR=xvidcore
		time  bldmodule  xvidcore/build/generic
		cp -rf $SETUP_PATH/xvidcore/generic/include  $SETUP_PATH/$XVIDCOREDIR
		cp -rf $SETUP_PATH/xvidcore/generic/lib  $SETUP_PATH/$XVIDCOREDIR
	elif  [[ $2 == 8 ]]; then
		ZIMGDIR=zimg-master
		echo "============$ZIMGDIR compile mode"
		cd $ZIMGDIR
		./autogen.sh
		cd ../
		time  bldmodule  $ZIMGDIR
	elif  [[ $2 == 9 ]]; then
		cd $dirname
		mkdir -p /home/suker/work/rtmp
		sed  -i  's/prefix=\/usr\/local/prefix=\/home\/suker\/work\/rtmp/g'  Makefile
		sed  -i  's/prefix=\/usr\/local/prefix=\/home\/suker\/work\/rtmp/g'  librtmp/Makefile
		make  && make install
		cd ../
	elif  [[ $2 == 10 ]]; then
		cd $dirname
		./configure --prefix=$SETUP_PATH/$dirname\
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
		 --enable-gnutls \
		 --enable-libvidstab \
		 --enable-libsoxr \
		 --enable-frei0r \
		 --enable-libfribidi \
		 --disable-indev=sndio \
		 --disable-outdev=sndio \
		 --enable-librtmp \
		 --enable-libzimg \
		 --extra-cflags="-static -I$SETUP_PATH/install/include" \
		 --extra-ldflags="-L$SETUP_PATH/install/lib -L/usr/lib/x86_64-linux-gnu/" \
		 --extra-libs="-lexpat -lpng -lharfbuzz -lgomp -ldl  -lz -lpthread  -lstdc++ -lm -lrt -lfreetype -lgmp -lnettle -lidn -lhogweed -ltasn1 -lSDL" 

		make  && make install
#		 --extra-libs="-lexpat -lpng -lharfbuzz -lgomp -ldl  -lz -lpthread  -lstdc++ -lm -lrt -lfreetype -lgmp -lnettle -lidn -lhogweed -lp11-kit" 
		cd ../
	elif  [[ $2 == 12 ]]; then
		echo "============libgnutls dependence mode"
		#time  bldmodule $dirname   --with-libnettle-prefix=/usr
		time  bldmodule $dirname  --disable-shared  --without-p11-kit
#		time  bldmodule $dirname  --disable-shared  --with-included-libtasn1
#		time  bldmodule $dirname  --disable-shared  --with-libnettle-prefix=/usr/lib/x86_64-linux-gnu/  --with-included-libtasn1
#		time  bldmodule $dirname  --disable-shared  --with-libnettle-prefix=/usr/lib/x86_64-linux-gnu/  --with-included-libtasn1=/usr/lib/x86_64-linux-gnu/
	fi
}


#		 --enable-sdl2 \

#  --with-included-libtasn1
#	./configure --prefix=$SETUP_PATH/$dirname \
# 		--disable-srp-authentication\
#		--disable-psk-authentication\
#		--disable-anon-authentication\
#		--disable-openpgp-authentication\
#		--disable-dhe\
#		--disable-ecdhe\
#		--disable-openssl-compatibility\
#		--disable-dtls-srtp-support\
#		--disable-alpn-support\
#		--disable-heartbeat-support\
#		--disable-libdane\
#		--without-p11-kit\
#		--without-tpm\
#		--without-zlib\
#  && make && make install

cfgbld()
{
	comnbld $1 1
}

cmakebld()
{
	comnbld $1 2
}

withogg()
{
	comnbld $1 3
}

vidstab()
{
	git clone $1
	time  cmakemodule vid.stab
}

openjpeg()
{
	comnbld $1 5
}

x264bld()
{
	comnbld $1 6
}

xvidcord()
{
	comnbld $1 7
}

zimgbld()
{
	comnbld $1 8
}

rtmpbld()
{
	comnbld $1 9
}

x265bld()
{
	hg clone $1
	DSTDIR=x265/build/linux
	cd $DSTDIR
	./make-Makefiles.bash
	make
	mkdir -p $SETUP_PATH/x265/lib/pkgconfig
	mkdir -p $SETUP_PATH/x265/include/
	cp ./libx265.*              $SETUP_PATH/x265/lib/
	cp ./x265.pc                $SETUP_PATH/x265/lib/pkgconfig
	cp ./../../source/x265.h    $SETUP_PATH/x265/include/
	cp ./x265_config.h          $SETUP_PATH/x265/include/
	cd ../../../
#	make install
}


gnutlsbld()
{
	export CPPFLAGS="-I/home/suker/work/study/log/2016/06/24/ffmpegbld/build/install/include"
	export LDFLAGS="-L/home/suker/work/study/log/2016/06/24/ffmpegbld/build/install/lib"
#./configure --host=i686-w64-mingw32 --prefix="$HOME/prefix-win32" --disable-shared --with-included-libtasn1 --without-p11-kit --disable-doc --enable-local-libopts
	comnbld $1 12
}

mfxbld()
{
	git clone $1
	cmakebld mfx_dispatch
}

ffmbld()
{
#	export PATH=$PATH:/home/suker/work/study/log/2016/06/24/ffmpegbld/build/SDL2-2.0.4/include/SDL2:/home/suker/work/study/log/2016/06/24/ffmpegbld/build/SDL2-2.0.4/include:/home/#suker/work/study/log/2016/06/24/ffmpegbld/build/SDL2-2.0.4/lib
	comnbld $1 10
}
time  cfgbld    http://www.lysator.liu.se/~nisse/archive/nettle-3.2.tar.gz                                                            #ok
time  cfgbld    http://ftp.gnu.org/gnu/libtasn1/libtasn1-4.8.tar.gz                                                                   #ok
time  cfgbld    http://ftp.gnu.org/gnu/libidn/libidn-1.32.tar.gz                                                                      #ok
time  cfgbld    http://www.unbound.net/downloads/unbound-1.5.9.tar.gz                                                                 #ok
time  cfgbld    http://p11-glue.freedesktop.org/releases/p11-kit-0.23.2.tar.gz                                                        #ok
time  gnutlsbld ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/gnutls-3.5.0.tar.xz
time  cfgbld    https://www.fribidi.org/download/fribidi-0.19.7.tar.bz2                                                               #ok
time  cfgbld    https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz                                      #ok
time  cfgbld    https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.0.tar.bz2                                     #ok
time  cfgbld    http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.bz2                                               #ok
time  cmakebld  https://files.dyne.org/frei0r/releases/frei0r-plugins-1.5.0.tar.gz                                                    #ok
time  cfgbld    https://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz                                              #ok
time  cfgbld    https://github.com/libass/libass/releases/download/0.13.2/libass-0.13.2.tar.xz                                        #error(must have fribidi)
time  cmakebld  https://sourceforge.net/projects/soxr/files/soxr-0.1.2-Source.tar.xz                                                  #ok
time  vidstab    https://github.com/georgmartius/vid.stab.git                                                                          #ok(error bef)
time  cfgbld    http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz                                                            #ok
time  withogg   http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz                                                      #ok
time  withogg   http://downloads.xiph.org/releases/theora/libtheora-1.2.0alpha1.tar.xz                                                #ok
time  cfgbld    https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-0.1.3.tar.gz                            #ok
time  cfgbld    http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2                            #ok(need clean)
time  cfgbld    https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.5.0.tar.gz                           #ok
time  x264bld   ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2                                                           #ok(error bef)
time  cfgbld    https://sourceforge.net/projects/opencore-amr/files/vo-aacenc/vo-aacenc-0.1.3.tar.gz                                  #ok
time  cfgbld    https://sourceforge.net/projects/opencore-amr/files/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz                              #ok
time  cfgbld    http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz                                                             #ok
time  cfgbld    http://downloads.xiph.org/releases/speex/speex-1.2rc2.tar.gz                                                          #ok
time  openjpeg  https://github.com/uclouvain/openjpeg/archive/version.2.1.tar.gz                                                      #ok(error bef)
time  rtmpbld   https://ffmpeg.zeranoe.com/builds/source/external_libraries/rtmpdump-20151223-git-fa8646d.tar.xz                      #ok(error bef)
time  xvidcord  http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.bz2                                                            #ok(error bef)
time  zimgbld   https://github.com/sekrit-twc/zimg/archive/master.zip                                                                 #ok(error bef)
time  x265bld   https://bitbucket.org/multicoreware/x265                                                                              #ok
#time  mfxbld    https://github.com/lu-zero/mfx_dispatch.git                                                                           #ok
time  cfgbld    http://libsdl.org/release/SDL-1.2.15.tar.gz                                                                            #ok
time  ffmbld    http://ffmpeg.org/releases/ffmpeg-3.0.2.tar.bz2
#===============================================================================
#time  vidstab   https://github.com/georgmartius/vid.stab/tarball/release-0.98b/georgmartius-vid.stab-release-0.98b-0-g3b35b4d.tar.gz  #ok(error bef)
#https://github.com/georgmartius/vid.stab.git
#===============================================================================
#===============================================================================
#ln -s /usr/local/lib/libgnutls.so.28 /usr/lib/libgnutls.so.28

##echo https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz | cut -d "|" -f -1
##echo "1:3:5" | awk -F ":" '{print $NF}'
##	echo $1 | cut -d "|" -f -
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
#hg clone https://bitbucket.org/multicoreware/x265
#cd x265/build/linux
#./make-Makefiles.bash
#make
#make install
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
#	localname=`echo https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz | awk -F "/" '{print $NF}'`
#	printf "========curl get source:%s\n--------dest file:%s\n", $1, "$localname"
#-------------------------------------------------------------------------------

##	dirname=`echo $localname | awk -F ".tar.gz" '{print $NF}'`
#	echo $localname | awk '{print substr(,1,8)}'
#echo fontconfig-2.12.0.tar.bz2 | awk -F ".tar.gz" '{print $NF}'
#		tar -Jxvf $localname

##	printf "----------------dest file:$localname\n"

#		echo "$myVar is empty" 
#		exit 0 
#	if [ ! -n "$" ]; then 

#-------------------------------------------------------------------------------
#time  cfgbld  https://sourceforge.net/projects/zimg/files/zimg/zimg-5.0.0/zimg-5.0.0.tar.gz                                          #error
#https://github.com/sekrit-twc/zimg
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

#	find ./ -name Makefile | xargs grep -rn prefix=
#	find ./ -name Makefile | sed 's/prefix=/sukersuker=/g' 
#	echo "${SETUP_PATH}/${$1}"


#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#export PKG_CONFIG=/usr/bin/pkg-config
#export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/home/suker/work/study/log/2016/06/24/ffmpegbld/build/install/lib/pkgconfig
#/home/suker/work/study/log/2016/06/24/ffmpegbld/build/install/lib/pkgconfig
#export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

#libass-0.13.2.tar.xz
#checking for FRIBIDI... no
#configure: error: Package requirements (fribidi >= 0.19.0) were not met:
#No package 'fribidi' found
#Consider adjusting the PKG_CONFIG_PATH environment variable if you
#installed software in a non-standard prefix.
#Alternatively, you may set the environment variables FRIBIDI_CFLAGS
#and FRIBIDI_LIBS to avoid the need to call pkg-config.
#See the pkg-config man page for more details.
# pkg-config --list-all
#pkg-config --modversion fribidi

#-------------------------------------------------------------------------------


#mac os
#http://mac.softpedia.com/get/Development/Compilers/CMake.shtml#download
#https://cmake.org/
#/home/suker/work/study/log/2016/06/24/ffmpegbld/build
#/Users/zhoushuqiang/Desktop/suker/source/github.com/zhoushuqiang/ffmbld
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#time  cfgbld  http://downloads.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz                                                       #ok
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#http://libsdl.org/release/SDL2-2.0.4.tar.gz
#wget http://libsdl.org/release/SDL-1.2.15.tar.gz
#tar zxvf SDL-1.2.15.tar.gz
#cd SDL-1.2.15
#./configure --prefix=/usr
#make -j16
#sudo make install
#export PATH=$PATH:/home/suker/work/study/log/2016/06/24/ffmpegbld/build/SDL2-2.0.4/include/SDL2:/home/suker/work/study/log/2016/06/24/ffmpegbld/build/SDL2-2.0.4/include:/home/suker/work/study/log/2016/06/24/ffmpegbld/build/SDL2-2.0.4/lib
#-------------------------------------------------------------------------------
#./configure \
#--prefix=/usr/local --shlibdir=/usr/local/lib64 --libdir=/usr/local/lib64 \
#--mandir=/usr/local/man --incdir=/usr/local/include \
#--enable-gpl --enable-nonfree --enable-version3 \
#--enable-x11grab --enable-libdc1394 \
#--enable-avfilter --enable-pthreads \
#--enable-postproc --enable-libvpx \
#--enable-libx264 --enable-libxvid \
#--enable-libopencore-amrnb  --enable-libopencore-amrwb \
#--enable-libdirac --enable-libschroedinger \
#--enable-libmp3lame --enable-libfaac \
#--enable-libtheora --enable-libvorbis \
#--enable-libfreetype --enable-filter=drawtext \
#--enable-static \
#--disable-shared
#-------------------------------------------------------------------------------
#./src/video/x11/SDL_x11sym.h
#SDL_X11_SYM(int,_XData32,(Display *dpy,register long *data,unsigned len),(dpy,data,len),return)-->
#SDL_X11_SYM(int,_XData32,(Display *dpy,register _Xconst long *data,unsigned len),(dpy,data,len),return)
#-------------------------------------------------------------------------------

