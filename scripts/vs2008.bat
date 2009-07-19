SET make_type="NMake Makefiles"
SET build_type="Release"

SET eigen_dir="S:\src\eigen2"
SET libxml2_dir="C:\build\libxml2"

cmake -DEIGEN2_INCLUDE_DIR=%eigen_dir% -DLIBXML2_LIBRARIES=%libxml2_dir%\lib\libxml2.lib -DLIBXML2_INCLUDE_DIR=%libxml2_dir%\include -Dlibxml2_DIR=%libxml2_dir%\lib -DCMAKE_BUILD_TYPE=%build_type% -G %make_type% S:\src\avogadro-super

