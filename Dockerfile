RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the application files
COPY . /app/

# Expose the custom port
EXPOSE 8080

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]