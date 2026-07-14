# Tạo kho chứa Image cho Frontend và Backend
resource "aws_ecr_repository" "cms_frontend" {
  name                 = "cms-97-frontend"
  image_tag_mutability = "MUTABLE"
  
  image_scanning_configuration {
    scan_on_push = true # Tự động quét lỗ hổng bảo mật khi push code
  }
}

resource "aws_ecr_repository" "cms_backend" {
  name                 = "cms-97-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Chính sách dọn rác (Lifecycle Policy): Chỉ giữ lại 30 Image mới nhất
resource "aws_ecr_lifecycle_policy" "frontend_cleanup" {
  repository = aws_ecr_repository.cms_frontend.name
  policy     = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 30 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 30
      }
      action = { type = "expire" }
    }]
  })
}

resource "aws_ecr_lifecycle_policy" "backend_cleanup" {
  repository = aws_ecr_repository.cms_backend.name
  policy     = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 30 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 30
      }
      action = { type = "expire" }
    }]
  })
}
# IlBMF2aC1H0OiSZU