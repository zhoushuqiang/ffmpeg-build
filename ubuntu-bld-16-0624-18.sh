#!/bin/bash

#suker-2016-0624 add for ffmpeg link thirdparty libs build

#http://ffmpeg.org/download.html
#http://www.ffmpeg.org/general.html
#http://johnvansickle.com/ffmpeg/release-source/
#https://ffmpeg.zeranoe.com/builds/
#http://pkgs.repoforge.org/

length=0

bldmodule()
{
	echo ==================================================build module $1 begin
	cd $1
	./configure --prefix=/home/suker/work/study/log/2016/06/24/ffmpegbld/build/$1 && make && make install
	cd ../
	echo ==================================================build module $1 end
}

curlgetsrc()
{
	localname=`echo $1 | awk -F "/" '{print $NF}'`
	length=`expr $length + 1`
	echo "index:$length, ========curl get source:$1"
#	curl -L  $1 -o $localname
	if [[ $1 =~ "tar.gz" ]]; then
#		echo "\$1 contains tar.gz"
		tar -zxf $localname
	elif [[ $1 =~ "tar.bz2" ]]; then
#		echo "\$1 contains tar.bz2"
		tar -jxf $localname
	elif [[ $1 =~ "tar.xz" ]]; then
#		echo "\$1 contains tar.xz"
		tar -Jxf $localname
	fi

	bldmodule $localname
}


#		tar -Jxvf $localname

##	printf "----------------dest file:$localname\n"

#		echo "$myVar is empty" 
#		exit 0 
#	if [ ! -n "$" ]; then 


curlgetsrc  https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz
curlgetsrc  https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.0.tar.bz2
curlgetsrc  http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.bz2
curlgetsrc  https://files.dyne.org/frei0r/releases/frei0r-plugins-1.5.0.tar.gz
curlgetsrc  https://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz
curlgetsrc  https://github.com/libass/libass/releases/download/0.13.2/libass-0.13.2.tar.xz
curlgetsrc  https://sourceforge.net/projects/soxr/files/soxr-0.1.2-Source.tar.xz
curlgetsrc  https://github.com/georgmartius/vid.stab/tarball/release-0.98b/georgmartius-vid.stab-release-0.98b-0-g3b35b4d.tar.gz
curlgetsrc  http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz
curlgetsrc  http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz
curlgetsrc  http://downloads.xiph.org/releases/theora/libtheora-1.2.0alpha1.tar.xz
curlgetsrc  https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-0.1.3.tar.gz
curlgetsrc  http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2
curlgetsrc  https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.5.0.tar.gz
curlgetsrc  ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
curlgetsrc  https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-0.1.3.tar.gz
curlgetsrc  https://sourceforge.net/projects/opencore-amr/files/vo-aacenc/vo-aacenc-0.1.3.tar.gz
curlgetsrc  https://sourceforge.net/projects/opencore-amr/files/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz
curlgetsrc  http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz
curlgetsrc  http://downloads.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz
curlgetsrc  https://github.com/uclouvain/openjpeg/archive/version.2.1.tar.gz
curlgetsrc  https://ffmpeg.zeranoe.com/builds/source/external_libraries/rtmpdump-20151223-git-fa8646d.tar.xz
curlgetsrc  http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.bz2
curlgetsrc  https://sourceforge.net/projects/zimg/files/zimg/zimg-5.0.0/zimg-5.0.0.tar.gz
curlgetsrc  http://ffmpeg.org/releases/ffmpeg-3.0.2.tar.bz2
#===============================================================================
#===============================================================================
#===============================================================================
#===============================================================================

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
#	localname=`echo https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.4.tar.gz | awk -F "/" '{print $NF}'`
#	printf "========curl get source:%s\n--------dest file:%s\n", $1, "$localname"
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

