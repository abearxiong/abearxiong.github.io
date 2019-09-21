
(function () {
    setTimeout(() => {
        location.reload()
    }, 20 * 1000);
})()

window.onload = function () {

}
//// ####
let resumeNav = $("#resume-nav")
let hideResumeNav= $("#hideResumeNav")
let showNav = $("#show-nav")
hideResumeNav.click(function(){
    resumeNav.addClass("animation bounce delay-1s")
    resumeNav.hide();
})
showNav.click(function(){
    resumeNav.toggle()
})

let reviewsShow = $(".my-reviews-show")
let reviewsContent = $("#gitalk-container")
reviewsShow.click(function(){
	reviewsContent.toggle()
})