// Created by iWeb 2.0.3 local-build-20080527

setTransparentGifURL('../Media/transparent.gif');function applyEffects()
{var registry=IWCreateEffectRegistry();registry.registerEffects({shadow_0:new IWShadow({blurRadius:4,offset:new IWPoint(1.4142,1.4142),color:'#463c3c',opacity:0.800000})});registry.applyEffects();}
function hostedOnDM()
{return false;}
function onPageLoad()
{loadMozillaCSS('Archive_files/ArchiveMoz.css')
detectBrowser();fixAllIEPNGs('../Media/transparent.gif');Widget.onload();fixupIECSS3Opacity('id1');applyEffects()}
function onPageUnload()
{Widget.onunload();}
