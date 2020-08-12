webpackJsonp([111],{478:function(e,t){e.exports={content:["section",["p","Note: Just for selecting picture. Generally ",["code","ImagePicker"]," is used to select picture before uploading, but without the feature of uploading. In this Component, we use Promise. Please refer to the description of compatibility in this ",["a",{title:null,href:"https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise"},"Promise document"],".If necessary, refer to ",["a",{title:null,href:"/docs/react/introduce"},"/docs/react/introduce-cn"]," for compatibility processing."]],meta:{category:"Components",type:"Data Entry",title:"ImagePicker",filename:"components/image-picker/index.en-US.md"},api:["section",["h2","API"],["table",["thead",["tr",["th","Properties"],["th","Descrition"],["th","Type"],["th","Default"]]],["tbody",["tr",["td","files"],["td","Picture files array which includes ",["code","url"],"(required) in each object"],["td","Array"],["td","[]"]],["tr",["td","onChange"],["td","Callback is called when the value of ",["code","files"]," is changed. The ",["code","operationType"]," is one of ",["code","add"]," or ",["code","remove"],"(the third argument is the removed index)."],["td","(files: Object, operationType: string, index: number): void"],["td"]],["tr",["td","onImageClick"],["td","Callback is called when the user clicks the selected picture"],["td","(index: number, files: Object): void"],["td"]],["tr",["td","onAddImageClick"],["td","Callback is called when the selector button is clicked"],["td","(): void"],["td"]],["tr",["td","onFail"],["td","failed selection"],["td","(msg: string): void"],["td"]],["tr",["td","selectable"],["td","whether to show selector button"],["td","boolean"],["td","true"]],["tr",["td","multiple"],["td","whether support choose multi images at once"],["td","boolean"],["td","false"]],["tr",["td","accept"],["td","File type accept"],["td","string"],["td","image/*"]],["tr",["td","length"],["td","Number of images in line"],["td","string ","|"," number"],["td","4"]],["tr",["td","capture"],["td","Image capture setting, please refer to the description of capture in ",["a",{title:null,href:"https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/Input"},"MDN"]],["td","boolean ","|"," string"],["td","false"]],["tr",["td","disableDelete"],["td","whether to hide delete icon"],["td","boolean"],["td","false"]]]]]}}});