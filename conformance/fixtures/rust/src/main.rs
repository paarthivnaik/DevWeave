pub fn parse_status_code(code: u16) -> bool {
    (200..300).contains(&code)
}

fn main() {
    println!("DevWeave Rust Sample Status: {}", parse_status_code(200));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_status() {
        assert!(parse_status_code(204));
        assert!(!parse_status_code(404));
    }
}
