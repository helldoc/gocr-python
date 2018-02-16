
%module gocr_py

%include<pybuffer.i>

// This tells SWIG to treat char ** as a special case
%typemap(in) char ** {
  /* Check if is a list */
  if (PyList_Check($input)) {
    int size = PyList_Size($input);
    int i = 0;
    $1 = (char **) malloc((size+1)*sizeof(char *));
    for (i = 0; i < size; i++) {
      PyObject *o = PyList_GetItem($input,i);
      if (PyString_Check(o))
        $1[i] = PyString_AsString(PyList_GetItem($input,i));
      else {
        PyErr_SetString(PyExc_TypeError,"list must contain strings");
        free($1);
        return NULL;
      }
    }
    $1[i] = 0;
  } else {
    PyErr_SetString(PyExc_TypeError,"not a list");
    return NULL;
  }
}

// This cleans up the char ** array we malloc'd before the function call
%typemap(freearg) char ** {
  free((char *) $1);
}

%typemap(out) char ** { 

   int ntokens; 
   int itoken; 
   PyObject *py_string_tmp; 
   int py_err; 
   /* compute len of the list */ 
   for (ntokens = 0; $1[ntokens] != NULL; ntokens++) { 
   /*
      WARNING: this loop cause segfault on most machines
      for default char *my_array[n], 
      because my_array[n] - NOT INITIALIZED AT ALL, not even NULL
      BUT: there is my convention in code returning char ** to TERMINATE ARRAY WITH NULL POINTER
   */
   }
   /* create Python empty list */ 
   $result = PyList_New(ntokens); 
   if (! $result) return NULL; 

   /* fill Python list */ 
   for (itoken = 0; itoken < ntokens; itoken++) { 
       if ($1[itoken] == NULL) break; 

       /* convert C string to Python string */ 
       py_string_tmp = PyString_FromString( $1[itoken] ); 
       if (! py_string_tmp) return NULL; 

       /* put Python string into the list */ 
       py_err = PyList_SetItem($result, itoken, py_string_tmp); 
       if (py_err == -1) return NULL; 
   } 


   /* Pyhon list is a copy a C list, delete C list */ 
   
   for (itoken = 0; itoken < ntokens; itoken++) { 
       free($1[itoken]); 
   }
   
   free($1); 

   /* return Python result */ 
   return $result; 
} 

%pybuffer_binary(unsigned char *bytes, size_t length)

/**************************************************************/

extern int gocr_main(int argc, char **argv);
extern char **process_path(const char *path);
extern char **process_image(unsigned char *bytes, size_t length);
