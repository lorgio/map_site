// Created by iWeb 2.0.3 local-build-20080527

setTransparentGifURL('../Media/transparent.gif');function applyEffects()
{var registry=IWCreateEffectRegistry();registry.registerEffects({shadow_0:new IWShadow({blurRadius:4,offset:new IWPoint(1.4142,1.4142),color:'#463c3c',opacity:0.800000}),stroke_0:new IWPhotoFrame([IWCreateImage('Blog_files/Freestyle_01.png'),IWCreateImage('Blog_files/Freestyle_02.png'),IWCreateImage('Blog_files/Freestyle_03.png'),IWCreateImage('Blog_files/Freestyle_06.png'),IWCreateImage('Blog_files/Freestyle_09.png'),IWCreateImage('Blog_files/Freestyle_08.png'),IWCreateImage('Blog_files/Freestyle_07.png'),IWCreateImage('Blog_files/Freestyle_04.png')],null,2,0.800000,3.000000,3.000000,3.000000,3.000000,22.000000,24.000000,23.000000,25.000000,166.000000,222.000000,166.000000,222.000000,null,null,null,0.100000),shadow_1:new IWShadow({blurRadius:3,offset:new IWPoint(0.0000,0.0000),color:'#463c3c',opacity:1.000000})});registry.applyEffects();}
function hostedOnDM()
{return false;}
function photocastSubscribe()
{photocastHelper("http://lorgiojimenez.com/personal/Blog/rss.xml");}
function onPageLoad()
{loadMozillaCSS('Blog_files/BlogMoz.css')
adjustLineHeightIfTooBig('id1');adjustFontSizeIfTooBig('id1');detectBrowser();Widget.onload();fixAllIEPNGs('../Media/transparent.gif');fixupAllIEPNGBGs();fixupIECSS3Opacity('id2');IMpreload('Blog_files','shapeimage_3','0');applyEffects()}
function onPageUnload()
{Widget.onunload();}
