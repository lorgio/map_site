// Created by iWeb 2.0.3 local-build-20080527

function createMediaStream_id1()
{return IWCreatePhotocast("http://lorgiojimenez.com/personal/St._Thomas_files/rss.xml",true,true);}
function initializeMediaStream_id1()
{createMediaStream_id1().load('http://lorgiojimenez.com/personal',function(imageStream)
{var entryCount=imageStream.length;var headerView=widgets['widget1'];headerView.setPreferenceForKey(imageStream.length,'entryCount');NotificationCenter.postNotification(new IWNotification('SetPage','id1',{pageIndex:0}));});}
function layoutMediaGrid_id1(range)
{createMediaStream_id1().load('http://lorgiojimenez.com/personal',function(imageStream)
{if(range==null)
{range=new IWRange(0,imageStream.length);}
IWLayoutPhotoGrid('id1',new IWPhotoGridLayout(3,new IWSize(184,184),new IWSize(184,34),new IWSize(221,233),27,27,0,new IWSize(0,0)),new IWStrokeParts([{rect:new IWRect(-5,3,8,175),url:'St._Thomas_files/stroke.png'},{rect:new IWRect(-5,-3,8,6),url:'St._Thomas_files/stroke_1.png'},{rect:new IWRect(3,-3,176,6),url:'St._Thomas_files/stroke_2.png'},{rect:new IWRect(179,-6,10,9),url:'St._Thomas_files/stroke_3.png'},{rect:new IWRect(179,3,8,175),url:'St._Thomas_files/stroke_4.png'},{rect:new IWRect(179,178,8,9),url:'St._Thomas_files/stroke_5.png'},{rect:new IWRect(3,178,176,12),url:'St._Thomas_files/stroke_6.png'},{rect:new IWRect(-3,178,6,12),url:'St._Thomas_files/stroke_7.png'}],new IWSize(184,184)),imageStream,range,null,null,1.000000,{backgroundColor:'#000000',reflectionHeight:100,reflectionOffset:2,captionHeight:100,fullScreen:0,transitionIndex:2},'Media/slideshow.html','widget1','widget2','widget3')});}
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
loadMozillaCSS('St._Thomas_files/St._ThomasMoz.css')
NotificationCenter.addObserver(null,relayoutMediaGrid_id1,'RangeChanged','id1')
fixAllIEPNGs('Media/transparent.gif');Widget.onload();fixupIECSS3Opacity('id2');initializeMediaStream_id1()
performPostEffectsFixups()}
function onPageUnload()
{Widget.onunload();}
