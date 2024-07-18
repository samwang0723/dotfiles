# Rust

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    rustc --version
    cargo --version

## Update Rust

    rustup update

## Create new project

    cargo new {{project}}

## Code coverage

    $ pip install git+https://github.com/Codium-ai/cover-agent.git
    $ cargo install cargo-tarpaulin
    $ cargo tarpaulin --out xml
    
    cover-agent \
      --source-file-path "src/utils/validator.rs" \
      --test-file-path "src/utils/validator.rs" \
      --test-command "cargo tarpaulin --out xml" \
      --desired-coverage 70 \
      --max-iterations 10 \
      --code-coverage-report-path "cobertura.xml" \
      --coverage-type "cobertura"

## Start a Project

    $ cargo new hello-rust
    $ cargo run

    # Add library
    $ cargo add {package-name}
    $ cargo build

- *build your project with `cargo build`*
- *run your project with `cargo run`*
- *test your project with `cargo test`*
- *build documentation for your project with `cargo doc`*
- *publish a library to [crates.io](https://crates.io/) with `cargo publish`*

## Knowledge
*In Rust, the **`derive`** attribute allows you to automatically implement certain traits for types. This is a form of metaprogramming that leverages the language's trait system to generate standard implementations of common functionality, reducing boilerplate code.*

1. ***Ownership and Allocation**:*
    - **`*String`**: **`String`** is an owned string type, which means it owns the data it holds. It's allocated on the heap, and its size can be changed at runtime, allowing for operations like appending.*
    - **`*&str`**: **`&str`** is a string slice, which is a reference to a portion of a string data. It doesn't own the data it points to, and is often used to borrow a slice of a **`String`** or a string literal.*
2. ***Mutability**:*
    - **`*String`**: Being an owned type, **`String`** can be modified, for example by pushing more characters or strings onto it, or by changing the characters it contains.*
    - **`*&str`**: **`&str`** is immutable. If it's derived from a **`String`**, it will reflect the state of the **`String`** at the time it was borrowed.*
3. ***Size**:*
    - **`*String`**: The size of a **`String`** can change as it can allocate more space on the heap as needed.*
    - **`*&str`**: The size of a **`&str`** is fixed and cannot change.*
4. ***Usage**:*
    - **`*String`**: **`String`** is typically used when you want to own and modify string data.*
    - **`*&str`**: **`&str`** is used when you want to borrow and read string data without taking ownership.*
5. ***Creation**:*
    - **`*String`**: A **`String`** can be created from a string literal by calling **`to_string()`** or **`String::from()`**.*
    - **`*&str`**: A **`&str`** can be created directly from a string literal, or by borrowing a **`String`**.*
6. ***Performance**:*
    - **`*String`**: Operations on **`String`** may cause heap allocations, which can be relatively slow.*
    - **`*&str`**: Operations on **`&str`** are usually faster as they don't involve heap allocations.*

*In summary, if you need to own and possibly modify string data, you would use **`String`**. If you only need to read or borrow string data, **`&str`** is a better choice for performance and should be used wherever possible.*

## Concurrency
*In concurrent programming, both semaphores and thread pools are used to control the execution of concurrent tasks, but they serve different purposes and are used in different contexts.*

### ***Semaphore***

*A semaphore is a low-level synchronization primitive that is used to control access to a common resource by multiple threads in a concurrent system. It maintains a set of permits, and threads must obtain a permit from the semaphore before they can proceed with certain operations. When a semaphore's count is greater than zero, a thread can acquire a permit, which will decrement the count. If the count is zero, the thread will block until a permit becomes available (usually when another thread releases a permit).*

*In Rust, **`Arc::new(Semaphore::new(3))`** would be used like this:*

- *You create a semaphore with a certain number of permits (3 in your case).*
- *Before a thread starts its work (like fetching and parsing data), it acquires a permit from the semaphore.*
- *Once the work is done or the data is sent through a channel, the permit is released.*
- *This controls that only 3 threads can do the specific work concurrently.*

*The semaphore doesn't spawn or manage threads itself; it's just a counting mechanism.*

### ***Thread Pool***

*A thread pool, on the other hand, is a higher-level construct that manages a pool of worker threads. When you spawn a task in a thread pool, the pool will assign a thread to execute that task. Once the task is completed, the thread becomes available again for other tasks. The main advantages of using a thread pool are:*

- *Reusing threads: Creating and destroying threads can be expensive in terms of performance. A thread pool allows you to reuse a fixed number of threads to execute tasks, which can be more efficient.*
- *Limiting concurrency: By configuring the number of threads in the pool, you implicitly limit the number of concurrent tasks. If all threads are busy, additional tasks will wait until a thread becomes available.*

*In Rust, creating a thread pool and using it to spawn tasks would look like this:*

- *You create a thread pool with a specified number of threads (again, 3 for your case).*
- *You then use this pool to execute tasks, which are typically closures in Rust.*
- *The pool manages the execution of these tasks, ensuring that at most 3 tasks are running at any given time.*

*Here's a simple comparison:*

- ***Semaphore**: Controls access to resources by counting permits. You manually manage threads and ensure they acquire and release permits.*
- ***Thread Pool**: Manages threads for you, running a fixed number of tasks concurrently. You just queue tasks, and the pool handles execution and thread management.*

*In your case, you could use either:*

- ***With a Semaphore**: You can control the concurrent access to the resources, such as limiting the number of concurrent network requests.*
- ***With a Thread Pool**: You can manage the execution of tasks and reuse threads efficiently.*

*Choosing one over the other depends on the requirements of your application and where you need to exert control. If you're simply looking to limit the number of concurrent tasks, a thread pool is usually the simpler and more idiomatic choice in Rust. If you need fine-grained control over resource access and are possibly dealing with many short-lived tasks or a very high number of tasks, a semaphore may be more appropriate.*

*Asynchronous tasks in Rust, especially when combined with non-blocking I/O, can be incredibly efficient for operations like network requests because they don't need a separate OS thread for each task. They simply yield control while waiting for I/O operations to complete, allowing other tasks to run.*

*However, if you want to enforce a limit on queries per second while potentially using multiple OS threads, you might still use a thread pool alongside a semaphore. This way, you get the concurrency of a thread pool with the rate limiting of a semaphore. The Tokio runtime can be configured to use a multi-threaded scheduler as well, allowing for work to be scheduled across multiple threads.*

*Here's how you could adjust the Tokio runtime to use multiple threads:*

```rust
*#[tokio::main(flavor = "multi_thread", worker_threads = 4)]
async fn main() {
    // ...
}*
```

*By setting **`flavor = "multi_thread"`** and specifying **`worker_threads = 4`**, you are configuring the Tokio runtime to use 4 OS threads. This means your asynchronous tasks can now run concurrently across multiple threads. This is useful if your workload can benefit from parallelism (like CPU-bound work) alongside concurrency.*

*When you are crawling and parsing data that is mainly I/O-bound, it's generally more efficient to use asynchronous operations with a single-threaded runtime. But if you have CPU-bound work to perform in each task (like complex computations on the data you retrieve), you might benefit from a multi-threaded runtime. This allows the CPU-bound work to be parallelized across multiple cores.*

*For network-bound applications, especially those involving crawling websites, using an asynchronous approach with a semaphore to rate-limit your requests is typically the most efficient and straightforward method, even if it operates on a single thread. If the website has strict rate limiting and you are worried about being blocked, this pattern is usually preferable to multi-threading, as it gives you fine-grained control over the number of concurrent requests.*

*For your use case—web crawling with a rate limit—it's important to consider:*

- ***Rate Limiting**: If you’re mainly concerned with rate limiting (like 3 QPS), then both a semaphore with an asynchronous event loop or a thread pool can be used. A semaphore is more straightforward for controlling the exact rate of requests.*
- ***Task Nature**: If the tasks are I/O-bound (which is usually the case with web requests), an asynchronous event loop would be more resource-efficient.*
- ***Concurrency Need**: If you need to perform CPU-bound work after fetching the data, and you want to leverage multiple cores, a thread pool would be beneficial.*

*Therefore, if you're looking to ensure you don't exceed a QPS of 3 and your work is I/O-bound, you could use an asynchronous model with a semaphore. If you have additional CPU-bound processing and the server can handle multithreaded loads without violating the QPS limit, a thread pool could be considered.*

*To use a thread pool with OS-level threads in Rust, you'd usually work with a crate like **`rayon`** or use the standard library's **`thread::spawn`** to manually manage threads. However, remember that in such cases, you'll also need a mechanism (like a semaphore) to enforce the rate limit, because thread pools alone don't provide built-in rate limiting.*

---

### ***Tokio Runtime with Multi-Threaded Flavor***

*When you specify **`#[tokio::main(flavor = "multi_thread", worker_threads = 4)]`**, you are configuring the Tokio runtime to use a multi-threaded scheduler with 4 worker threads. This means:*

- ***Multi-threaded Scheduler**: Tokio will use multiple OS threads (4 in this case) to schedule and execute asynchronous tasks.*
- ***Concurrent Execution**: These tasks can potentially execute concurrently across these 4 threads, depending on system resources and scheduler implementation.*

### ***Semaphore with 3 Permits***

*When you wrap a semaphore with 3 permits in an **`Arc`** (Atomic Reference Counted pointer) and share it across your tasks like **`Arc::new(Semaphore::new(3))`**, you are setting a concurrency limit for a certain resource or operation. In this context:*

- ***Concurrency Limit**: At most, 3 tasks can hold a permit from the semaphore at the same time, regardless of how many worker threads you have in the Tokio runtime.*
- ***Resource Control**: The semaphore is used to control the rate at which certain operations (like HTTP requests) are performed, effectively limiting the rate to 3 concurrent operations at any given time.*

### ***Interaction between Multi-Threaded Scheduler and Semaphore***

*Here's how they work together:*

- ***Worker Threads**: You have up to 4 OS threads that can run tasks concurrently. However, the actual concurrency of tasks that are waiting for or holding a semaphore permit is managed by the semaphore, not the number of threads.*
- ***Semaphore Permits**: The semaphore ensures that, regardless of the number of threads available, only 3 tasks can perform the semaphore-guarded operation concurrently.*

*To put it simply:*

- *The **`worker_threads = 4`** configuration allows the runtime to execute up to 4 asynchronous tasks concurrently across different threads.*
- *The **`Arc::new(Semaphore::new(3))`** configuration ensures that only 3 of those tasks can perform a certain action (like making a web request) at the same time.*

*If you have more than 3 tasks that need to acquire a semaphore permit, the additional tasks will have to wait even if there are idle threads available. This way, you can have a multi-threaded environment while still respecting the rate limit imposed by the semaphore.*

---

*In Rust, whether you should use **`async`** for a function typically depends on what that function does:*

1. ***I/O-bound work**: If your function is performing I/O operations, like reading from a file, making a network request, or accessing a database, you should ideally use **`async`**. This allows the function to yield control when it would otherwise be blocked, letting other tasks run on the same thread.*
2. ***CPU-bound work**: If your function is doing CPU-bound work, such as generating a string based on some intensive computation, **`async`** won't provide any benefit if you're already calling this function within a separate thread. CPU-bound work will block the thread it's running on, so if this function is executed within the context of a Tokio task, you might offload it to a thread pool designed for blocking operations, like **`tokio::task::spawn_blocking`**.*

*Now, let's break down your specific situation:*

- *You have a function that generates a string based on an input string.*
- *You intend to call this function in a thread (I'm assuming a separate thread, possibly using **`tokio::task::spawn_blocking`** or **`std::thread::spawn`**).*

*Given this, here’s what to consider:*

- *If the string generation is quick and non-blocking, you do not need to make the function **`async`**. Just call it directly within your thread.*
- *If the string generation is somehow I/O-bound or may benefit from being able to yield (for example, if it waits on some asynchronous event), then marking it as **`async`** could be beneficial.*
- *If the function is CPU-bound but you're already executing it within a separate thread, there's no need to use **`async`**. However, in the context of a Tokio application, you should generally use **`tokio::task::spawn_blocking`** to offload blocking operations to a thread where blocking is acceptable.*

*Here's a simple rule of thumb:*

- *Use **`async`** when you want non-blocking, concurrent execution of I/O-bound operations.*
- *Use threads (or **`spawn_blocking`**) for blocking, CPU-bound operations.*

*Finally, if this function is being called frequently or from multiple places concurrently, make sure you're considering the potential impact on performance and whether you need mechanisms in place to manage concurrency, such as throttles, queues, or load shedding.*

```rust
use tokio::sync::{Semaphore, mpsc};
use std::sync::Arc;

async fn crawl_url(url: String) {
    // ... your crawling logic here
}

#[tokio::main]
async fn main() {
    let semaphore = Arc::new(Semaphore::new(50));
    let (tx, mut rx) = mpsc::channel(1900 * 5);

    // Spawn a task for each URL
    for _ in 0..1900 {
        for _ in 0..5 {
            let url = generate_url(); // Replace with actual URL generation
            tx.send(url).await.expect("Failed to send URL");
        }
    }

    let mut handles = Vec::new();
    for _ in 0..50 {
        let semaphore_clone = semaphore.clone();
        let mut rx_clone = rx.clone();
        let handle = tokio::spawn(async move {
            while let Some(url) = rx_clone.recv().await {
                let _permit = semaphore_clone.acquire().await.expect("Failed to acquire semaphore");
                crawl_url(url).await;
            }
        });

        handles.push(handle);
    }

    // Close the sending side
    drop(tx);

    // Wait for all tasks to complete
    for handle in handles {
        handle.await.expect("Task panicked");
    }
}

fn generate_url() -> String {
    // ... generate the URL
    "http://example.com".to_string()
}

```
