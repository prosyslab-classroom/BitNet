# Quick Start

Please download the BitNet model:

```sh
hf download microsoft/BitNet-b1.58-2B-4T-gguf --local-dir models/BitNet-b1.58-2B-4T
```

If `hf` (hugging-face cli) is not available, you can download it via:
```sh
curl -LsSf https://hf.co/cli/install.sh | bash
```

We provide a conveninent wrapper to launch a BitNet server:

```sh
./run_inference.sh -n 128
```

This internally runs [run_inference_server.py] that spawns a `llama-server` of the BitNet model.
