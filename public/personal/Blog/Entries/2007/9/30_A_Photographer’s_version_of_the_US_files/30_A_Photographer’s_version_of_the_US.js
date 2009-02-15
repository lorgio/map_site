// Created by iWeb 2.0.3 local-build-20080527

setTransparentGifURL('../../../../Media/transparent.gif');function applyEffects()
{var registry=IWCreateEffectRegistry();registry.registerEffects({shadow_0:new IWShadow({blurRadius:4,offset:new IWPoint(0.0000,0.0000),color:'#463c3c',opacity:0.600000}),shadow_1:new IWShadow({blurRadius:3,offset:new IWPoint(0.0000,0.0000),color:'#463c3c',opacity:1.000000})});registry.applyEffects();}
function hostedOnDM()
{return false;}
function onPageLoad()
{dynamicallyPopulate();loadMozillaCSS('30_A_Photographer’s_version_of_the_US_files/30_A_Photographer’s_version_of_the_USMoz.css')
adjustLineHeightIfTooBig('id1');adjustFontSizeIfTooBig('id1');fixAllIEPNGs('../../../../Media/transparent.gif');Widget.onload();fixupIECSS3Opacity('id2');IMpreload('30_A_Photographer’s_version_of_the_US_files','shapeimage_4','0');IMpreload('30_A_Photographer’s_version_of_the_US_files','shapeimage_5','0');applyEffects()}
function onPageUnload()
{Widget.onunload();}
