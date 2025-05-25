FROM sagemath/sagemath:10.6

# Εγκατάσταση Voila και ipywidgets
RUN sage -pip install voila ipywidgets

# Δημιουργία φακέλου εφαρμογής
WORKDIR /app

# Αντιγραφή των αρχείων του project
COPY . /app

# Πόρτα για Render
EXPOSE 8888

# Εκκίνηση Voila
CMD ["voila", "--port=8888", "--no-browser", "--Voila.ip=0.0.0.0", "find-roots.ipynb"]
