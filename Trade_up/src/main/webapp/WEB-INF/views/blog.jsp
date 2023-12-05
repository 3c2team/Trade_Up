<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>

<body>
	<jsp:include page="inc/top.jsp"></jsp:include>


       <input type="file" id="file-input" multiple />
    <h3>업로드된 파일</h3>
    <div id="preview">
    </div>

<jsp:include page="inc/bottom.jsp"></jsp:include>
<script type="text/javascript">
const handler = {
        init() {
            const fileInput = document.querySelector('#file-input');
            const preview = document.querySelector('#preview');
            fileInput.addEventListener('change', () => {  
                console.dir(fileInput)                  
                const files = Array.from(fileInput.files)
                files.forEach(file => {
                    preview.innerHTML += `
                    <p id="${file.lastModified}">
                        ${file.name}
                        <button data-index='${file.lastModified}' class='file-remove'>X</button>
                    </p>`;
                });
            });
        },

        removeFile: () => {
            document.addEventListener('click', (e) => {
            if(e.target.className !== 'file-remove') return;
            const removeTargetId = e.target.dataset.index;
            const removeTarget = document.getElementById(removeTargetId);
            const files = document.querySelector('#file-input').files;
            const dataTranster = new DataTransfer();

            // document.querySelector('#file-input').files =
            //             Array.from(files).filter(file => file.lastModified !== removeTarget);

        
            Array.from(files)
                .filter(file => file.lastModified != removeTargetId)
                .forEach(file => {
                dataTranster.items.add(file);
             });

            document.querySelector('#file-input').files = dataTranster.files;

            removeTarget.remove();
        })
        }
    }

    handler.init()
    handler.removeFile()
</script>
</body>

</html>