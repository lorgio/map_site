// Created by iWeb 2.0.3 local-build-20080527

function writeMovie1()
{detectBrowser();if(windowsInternetExplorer)
{document.write('<object id="id1" classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" codebase="http://www.apple.com/qtactivex/qtplugin.cab" width="320" height="256" style="height: 256px; left: 190px; position: absolute; top: 68px; width: 320px; z-index: 1; "><param name="src" value="Media/Ibiza%202005-2%20Pete%20Tong%20Intro-desktop.m4v" /><param name="controller" value="true" /><param name="autoplay" value="false" /><param name="scale" value="tofit" /><param name="volume" value="100" /><param name="loop" value="false" /></object>');}
else if(isiPhone)
{document.write('<object id="id1" type="video/quicktime" width="320" height="256" style="height: 256px; left: 190px; position: absolute; top: 68px; width: 320px; z-index: 1; "><param name="src" value="The_White_Isle_files/Ibiza%202005-2%20Pete%20Tong%20Intro-desktop-1.jpg"/><param name="target" value="myself"/><param name="href" value="../Media/Ibiza%202005-2%20Pete%20Tong%20Intro-desktop.m4v"/><param name="controller" value="true"/><param name="scale" value="tofit"/></object>');}
else
{document.write('<object id="id1" type="video/quicktime" width="320" height="256" data="Media/Ibiza%202005-2%20Pete%20Tong%20Intro-desktop.m4v" style="height: 256px; left: 190px; position: absolute; top: 68px; width: 320px; z-index: 1; "><param name="src" value="Media/Ibiza%202005-2%20Pete%20Tong%20Intro-desktop.m4v"/><param name="controller" value="true"/><param name="autoplay" value="false"/><param name="scale" value="tofit"/><param name="volume" value="100"/><param name="loop" value="false"/></object>');}}
setTransparentGifURL('Media/transparent.gif');function applyEffects()
{var registry=IWCreateEffectRegistry();registry.registerEffects({shadow_0:new IWShadow({blurRadius:4,offset:new IWPoint(0.0000,0.0000),color:'#463c3c',opacity:0.680000})});registry.applyEffects();}
function hostedOnDM()
{return false;}
function onPageLoad()
{loadMozillaCSS('The_White_Isle_files/The_White_IsleMoz.css')
Widget.onload();fixAllIEPNGs('Media/transparent.gif');fixupIECSS3Opacity('id2');applyEffects()}
function onPageUnload()
{Widget.onunload();}
