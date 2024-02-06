use std::env;
use std::process::Command;

fn main() {
    // Set environment variables
    env::set_var("__NV_PRIME_RENDER_OFFLOAD", "1");
    env::set_var("__NV_PRIME_RENDER_OFFLOAD_PROVIDER", "NVIDIA-G0");
    env::set_var("__GLX_VENDOR_LIBRARY_NAME", "nvidia");
    env::set_var("__VK_LAYER_NV_optimus", "NVIDIA_only");

    // Get command-line arguments
    let args: Vec<String> = env::args().collect();

    // Execute the command
    if args.len() > 1 {
        let command = &args[1];
        let mut command_args = Vec::new();

        // Extract command arguments (skip the first argument which is the command itself)
        for arg in &args[2..] {
            command_args.push(arg);
        }

        // Execute the command with the modified environment
        let status = Command::new(command)
            .args(command_args)
            .status()
            .expect("Failed to execute command");

        // Check if the command was successful
        if !status.success() {
            eprintln!("Command failed with exit code: {}", status);
        }
    } else {
        eprintln!("Usage: ./your_program <command>");
    }
}
