use tokio::process::Command;
async fn lubuntu() -> std::process::ExitStatus {
    Command::new("bash")
        .arg("run.bash")
        .spawn()
        .expect("command failed to start")
        .wait()
        .await
        .expect("command failed to start.")
}

async fn viewer() -> std::process::ExitStatus {
    Command::new("bash")
        .arg("viewer.bash")
        .spawn()
        .expect("command failed to start")
        .wait()
        .await
        .expect("command failed to start.")
}
#[tokio::main]
async fn main() {
    println!("Starting Lubuntu Virtual Machine");
    tokio::join!(lubuntu(), viewer());
}
