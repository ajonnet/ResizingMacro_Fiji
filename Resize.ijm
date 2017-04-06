print("STARTED");
dirPath = "/Users/Amit/Desktop/Apple_images/DataSet/";
dirList = getFileList(dirPath);
for(i=0; i < dirList.length; i++) {
	if(endsWith(dirList[i],"/")){ //Check item is directory
		processDirectory(dirPath + dirList[i]);
	}	
}
print("ENDED");

function processDirectory(targDirPath) {
	print("Processing: " + targDirPath);
	
	opDirPath = "OP/";
	input = targDirPath;
	output = input + opDirPath;

	//Create and process the OP directory if does not exist
	if(!File.exists(output)) {
		File.makeDirectory(output);
		print("Output Directory Created");
		
		//Process all the files in directory
		setBatchMode(true);
		list = getFileList(input);
		print(list.length);
		for (i = 0; i < list.length; i++) {
			skipItemFlag = false;
			if(endsWith(list[i],"/")) skipItemFlag = true; //Check item should be a file
			
			if(!skipItemFlag) { 
				doResize(input, output, list[i]);
				print(output + list[i] + " CREATED");	
			}				
		}
		setBatchMode(false);	
	}else {
		print("Output directory already exist");
	}
}

function doResize(input, output, filename) {
    open(input + filename);
    height = getHeight();
    width = getWidth();
    if(width > height) {
		run("Scale...", "x=- y=- width=806 height=604 interpolation=Bilinear average create");     	
    }else if(width < height){
	 	run("Scale...", "x=- y=- width=604 height=806 interpolation=Bilinear average create"); 	
    } else { //Square image
 	 	run("Scale...", "x=- y=- width=604 height=604 interpolation=Bilinear average create");   	
    }

    saveAs("Tiff", output + filename);
    close();
}