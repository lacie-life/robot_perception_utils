# VTK + PCL + QT

1. Building VTK 9.0 with Qt 5.15

This procedure has been tested on Windows 10 and Debian-based Linux.

## Prerequisites
- CMake 3.8+ installed

- Qt 5.x downloaded. 
The Qt directory will be refered to as \<QT-DIR\>

- C++ compiler installed (like  GCC or  VS 2019). 
The compiler name will be refered to as \<COMPILER\>

## Building VTK
**a. Download VTK source code**

Download the source code from [http://VTK.org/download/](http://www.vtk.org/download/) and unpack it to a directory. This directory will be refered to as \<VTK-SOURCE-DIR\>

**b. Start CMake**

Start the CMake GUI application 

**c. Specify source  and build directory**

Source directory = \<VTK-SOURCE-DIR\> 

Build directory = \<VTK-SOURCE-DIR\>/Build (For example) 

**d. Start project configuration**

Specify a generator like 'Unix makefiles' on linux or 'MS Visual Studio 16 2019' on Windows.

**e. Specify entries and re-configure untill no more changes occur**

Set the following values when asked for:


| Name | Value |
| --- | --- |
| VTK_GROUP_ENABLE_Qt | YES |
| Qt5_DIR | \<QT-DIR\>/5.15.1/\<COMPILER\>/lib/cmake/Qt5 |
| VTK_Group_Qt | YES |
| VTK_MODULE_ENABLE_VTK_GUISupportQt | YES |
| CMAKE_BUILD_TYPE (Linux only, Makefiles) | Release |
| CMAKE_CONFIGURATION_TYPES (Windows only, MSVC) | Release |

Enable 'advanced' to see all entries and specify other Qt entries if they are not found automatically.

**f. Generate project**

Click on 'generate'. A buildable project will be created based on the chosen generator.

**g. Build project**

Build generated project using make (on Linux) or Visual Studio (on Windows)


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

        	b. Find the location of VTKConfig.cmake which was installed with VTK (eg, `/usr/local/lib/cmake/vtk-9.2`)  
 
			export VTK_PATH="<Location of VTKConfig.cmake>"  

		c. Run following commands:  

            cmake ../pcl-pcl-1.12.0/ -DQt5_DIR:PATH="${Qt5_PATH}/5.15.2/gcc_64/lib/cmake/Qt5" -DVTK_DIR:PATH=${VTK_PATH}  
		    make -j<Number of processors>  
		    sudo make install  
		
3. Configure VTK with QT.  
	a. After the VTK is built, inside **/VTK-9.2.0/build/lib** folder **libQVTKWidgetPlugin.so** file is generated. Go to the file location and open terminal.  
	b. Copy **libQVTKWidgetPlugin.so** to `<Qt_Installation_Path>/Tools/QtCreator/lib/Qt/plugins/designer` folder using following commands in terminal:  
		
		export Qt5_PATH="<Qt installation folder>"  
		cp libQVTKWidgetPlugin.so $Qt5_PATH/Tools/QtCreator/lib/Qt/plugins/designer/
