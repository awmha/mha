$(function() {
function addSocialMedia() {
  var i = 1;
  while ($('#social_media_' + i).length) {
    i++;
  }
  
  $('#social_media_1').clone().attr({
    id: "social_media_" + i,
    name: "social_media[" + i + "]"
  }).val('facebook').appendTo('#social_media');
  
  $('#social_media_values_1').clone().attr({
    id: "social_media_values_" + i,
    name: "social_media_values[" + i + "]"
  }).val('').appendTo('#social_media');
}
}