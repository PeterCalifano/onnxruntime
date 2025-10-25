# Ensure dependencies are installed
sudo apt install libgtest-dev libgmock-dev cmake

# Call build script passing default args

./build.sh --config RelWithDebInfo --build_shared_lib --parallel --compile_no_warning_as_error --use_cuda #--use_dnnl --use_openvino --use_tensorrt --use_tensorrt_builtin_parser



# Other options that could be useful
#--skip_submodule_sync --enable_nvtx_profile --enable_cuda_profiling
