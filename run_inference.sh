#!/bin/bash
BITNET_DIR="/BitNet"
MODEL_PATH="$BITNET_DIR/models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf"

# Parse command line arguments
while getopts "n:" opt; do
    case $opt in
        n)
            NUM_TOKENS="$OPTARG"
            ;;
        \?)
            echo "Usage: $0 -n <int>"
            echo "  -n <int>  Number of tokens"
            exit 1
            ;;
    esac
done

# Check if -n argument was provided
if [ -z "$NUM_TOKENS" ]; then
    echo "Error: -n argument is required"
    echo "Usage: $0 -n <int>"
    exit 1
fi

# Check if the model path exists
if [ ! -f "$MODEL_PATH" ]; then
    echo "Error: Model does not exist. Please run \`hf microsoft/BitNet-b1.58-2B-4T-gguf --local-dir <path>\` to download the model."
    exit 1
fi

# Run the inference server
cd $BITNET_DIR
python3 "$BITNET_DIR/run_inference_server.py" -m "$MODEL_PATH" -n "$NUM_TOKENS"
