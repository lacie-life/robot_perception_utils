1. Install VTK  

	a. Three software packages need to be installed before compiling VTK: X11, OpenGL, CMake.  
  
		sudo apt-get install libx11-dev libxext-dev libxtst-dev libxrender-dev libxmu-dev libxmuu-dev  
		sudo apt-get install build-essential libgl1-mesa-dev libglu1-mesa-dev  
		sudo apt-get install cmake cmake-qt-gui  

	b. Download source of VTK 8.2.0 from [here](https://vtk.org/download/).  
	c. UnzipVTK-8.2.0.tar.gz, create a build folder in the VTK-8.2.0 folder.  
	d. Create environment variable from Qt installation folder(location of folder **5.15.2**):  

		export Qt5_PATH="<Qt installation folder>"  

	e. Following commands will be used for VTK installation:  

		cmake .. -DVTK_Group_Qt:BOOL=TRUE -DVTK_QT_VERSION:VALUE=5 -DQT_QMAKE_EXECUTABLE:FILEPATH="${Qt5_PATH}/5.15.2/gcc_64/bin/qmake" -DQt5_DIR:PATH="${Qt5_PATH}/5.15.2/gcc_64/lib/cmake/Qt5" -DCMAKE_BUILD_TYPE:VALUE=Release  
		sudo make -j<Number of processors>  
		sudo make install  
f. Ref [here](https://gitlab.kitware.com/vtk/vtk/-/issues/18005) if have problem with "error: aggregate ‘QPainterPath path’ has incomplete type and cannot be defined"
    g. Locate the VTK directory containing the header files. This location is needed to be placed in **include_directories** command in line number **43** of **CMakeLists.txt**.  

2. Install PCL:  
    a. Download PCL 1.12 source code tar.gz from https://github.com/PointCloudLibrary/pcl/releases.  
    b. Create **PCL\_ROOT** folder, extract the tar.gz file inside it.  
    c. In **PCL\_ROOT** folder open terminal and provide following commands:  

		mkdir build && cd build  
		cmake ..  
		make -j<Number of processors>  
		sudo make install  
		
	Note:
	1. VTK and Qt dependencies are automatically detected by CMake for building but sometimes there is error thrown when they are not detected automatically. In that case follow below steps.  
		a. Create environment variable from Qt installation folder(location of folder **5.15.2**):   

			export Qt5_PATH="<Qt installation folder>"  

        	b. Find the location of VTKConfig.cmake which was installed with VTK (eg, `/usr/local/lib/cmake/vtk-8.2`)  
 
			export VTK_PATH="<Location of VTKConfig.cmake>"  

		c. Run following commands:  

            cmake ../pcl-pcl-1.12.0/ -DQt5_DIR:PATH="${Qt5_PATH}/5.15.2/gcc_64/lib/cmake/Qt5" -DVTK_DIR:PATH=${VTK_PATH}  
		    make -j<Number of processors>  
		    sudo make install  
		
3. Configure VTK with QT.  
	a. After the VTK is built, inside **/VTK-8.2.0/build/lib** folder **libQVTKWidgetPlugin.so** file is generated. Go to the file location and open terminal.  
	b. Copy **libQVTKWidgetPlugin.so** to `<Qt_Installation_Path>/Tools/QtCreator/lib/Qt/plugins/designer` folder using following commands in terminal:  
		
		export Qt5_PATH="<Qt installation folder>"  
		cp libQVTKWidgetPlugin.so $Qt5_PATH/Tools/QtCreator/lib/Qt/plugins/designer/
