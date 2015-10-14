function pytags
         find . -name '*.py' > cscope.files
         pycscope -R
end
