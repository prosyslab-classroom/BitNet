#!/bin/bash
BITNET_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
MODEL_PATH="$BITNET_DIR/models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf"
#MODEL_PATH="$BITNET_DIR/models/Qwen2.5-Coder-1.5B-Instruct/qwen2.5-coder-1.5b-instruct-q6_k.gguf"
#MODEL_PATH="$BITNET_DIR/models/Qwen2.5-Coder-1.5B-Instruct/qwen2.5-coder-1.5b-instruct-q4_k_m.gguf"
#MODEL_PATH="$BITNET_DIR/models/Qwen2.5-Coder-1.5B-Instruct/qwen2.5-coder-1.5b-instruct-q2_k.gguf"

# Parse command line arguments
while getopts "n:p:" opt; do
  case $opt in
    n)
      NUM_TOKENS="$OPTARG"
      ;;
    p)
      PROMPT="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 -n <int> -p <prompt>"
      echo "  -n <int>  Number of tokens"
      echo "  -p <string>  Prompt to use for inference"
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

# Check if -p argument was provided
if [ -z "$PROMPT" ]; then
  echo "Error: -p argument is required"
  echo "Usage: $0 -p <string>"
  exit 1
fi

# Check if the model path exists
if [ ! -f "$MODEL_PATH" ]; then
  echo "Error: Model does not exist. Please run \`hf microsoft/BitNet-b1.58-2B-4T-gguf --local-dir <path>\` to download the model."
  exit 1
fi

# Run the inference server
cd "$BITNET_DIR"
python3 "$BITNET_DIR/run_inference.py" -m "$MODEL_PATH" -cnv -p "$PROMPT" -n "$NUM_TOKENS"
