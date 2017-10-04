function updateWidth() {
  document.getElementById("window-width").innerHTML = document.documentElement.clientWidth;
}
window.addEventListener("resize", updateWidth);
updateWidth();
try {
  var mp3 = "data:audio/mpeg;base64,/+MYxAAAAANIAUAAAASEEB/jwOFM/0MM/90b/+RhST//w4NFwOjf///PZu////9lns5GFDv//l9GlUIEEIAAAgIg8Ir/JGq3/+MYxDsLIj5QMYcoAP0dv9HIjUcH//yYSg+CIbkGP//8w0bLVjUP///3Z0x5QCAv/yLjwtGKTEFNRTMuOTeqqqqqqqqqqqqq/+MYxEkNmdJkUYc4AKqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq";
  var audio = new Audio();
  audio.autoplay = true;
  audio.volume = 0;
  audio.addEventListener("play", function() {
    document.querySelector("html").classList.add("autoplay");
    document.querySelector("html").classList.remove("no-autoplay");
  });
  audio.src = mp3;
} catch (e) {
  document.getElementById("autoplay").innerHTML = e;
}
