// Created by iWeb 2.0.3 local-build-20080527

function createMediaStream_id1()
{return IWCreatePhotocast("http://lorgiojimenez.com/personal/Armin_files/rss.xml",true,true);}
function initializeMediaStream_id1()
{createMediaStream_id1().load('http://lorgiojimenez.com/personal',function(imageStream)
{var entryCount=imageStream.length;var headerView=widgets['widget1'];headerView.setPreferenceForKey(imageStream.length,'entryCount');NotificationCenter.postNotification(new IWNotification('SetPage','id1',{pageIndex:0}));});}
function layoutMediaGrid_id1(range)
{createMediaStream_id1().load('http://lorgiojimenez.com/personal',function(imageStream)
{if(range==null)
{range=new IWRange(0,imageStream.length);}
IWLayoutPhotoGrid('id1',new IWPhotoGridLayout(2,new IWSize(233,233),new IWSize(233,48),new IWSize(280,296),27,27,0,new IWSize(44,44)),new IWPhotoFrame([IWCreateImage('Armin_files/Crayon_BK_v4%20%2801%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2802%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2803%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2805%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2808%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2807%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2806%29.png'),IWCreateImage('Armin_files/Crayon_BK_v4%20%2804%29.png')],null,0,1.000000,19.000000,19.000000,19.000000,19.000000,41.000000,41.000000,41.000000,41.000000,2.000000,1.000000,2.000000,1.000000,null,null,null,0.100000),imageStream,range,new IWShadow({blurRadius:9,offset:new IWPoint(0.7071,0.7071),color:'#463c3c',opacity:0.300000}),null,1.000000,{backgroundColor:'#000000',reflectionHeight:100,reflectionOffset:2,captionHeight:100,fullScreen:0,transitionIndex:2},'Media/slideshow.html','widget1','widget2','widget3')});}
function relayoutMediaGrid_id1(notification)
{var userInfo=notification.userInfo();var range=userInfo['range'];layoutMediaGrid_id1(range);}
function onStubPage()
{var args=getArgs();parent.IWMediaStreamPhotoPageSetMediaStream(createMediaStream_id1(),args.id);}
if(window.stubPage)
{onStubPage();}
setTransparentGifURL('Media/transparent.gif');function hostedOnDM()
{return false;}
function onPageLoad()
{IWRegisterNamedImage('comment overlay','Media/Photo-Overlay-Comment.png')
IWRegisterNamedImage('movie overlay','Media/Photo-Overlay-Movie.png')
IWRegisterNamedImage('contribution overlay','Media/Photo-Overlay-Contribution.png')
loadMozillaCSS('Armin_files/ArminMoz.css')
NotificationCenter.addObserver(null,relayoutMediaGrid_id1,'RangeChanged','id1')
fixAllIEPNGs('Media/transparent.gif');Widget.onload();fixupIECSS3Opacity('id2');initializeMediaStream_id1()
performPostEffectsFixups()}
function onPageUnload()
{Widget.onunload();}
