/**
 * Created by sunjiaming on 10/8/15.
 */

function readURL(evt){
    var tgt = evt.target || window.event.srcElement,
        files = tgt.files;

    // FileReader support
    if (FileReader && files && files.length) {
        var fr = new FileReader();
        fr.onload = function () {
            document.getElementById('uploaded_image').src = fr.result;
        }
        fr.readAsDataURL(files[0]);
        document.getElementById('uploaded_image').style.display = 'inline';
    }
}
