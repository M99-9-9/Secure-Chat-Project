#!/usr/bin/env python3
"""
Secure Chat Project - Deployment Script
Handles building and pushing changes to Git
"""

import subprocess
import sys
import os
from pathlib import Path

def run_command(cmd, description=""):
    """Run a shell command and return the result"""
    if description:
        print(f"\n{description}...")
    try:
        result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
        print(f"✅ {description or 'Command'} completed")
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"❌ Error: {description or 'Command'} failed")
        print(f"Error output: {e.stderr}")
        sys.exit(1)

def main():
    """Main deployment function"""
    print("=" * 50)
    print("🚀 Secure Chat Project - Deployment")
    print("=" * 50)
    
    # Check project root
    if not Path("package.json").exists():
        print("❌ Error: package.json not found. Are you in the project root?")
        sys.exit(1)
    
    print("\n✅ Found project root")
    
    # Install dependencies
    run_command("pnpm install --no-frozen-lockfile", "📦 Installing dependencies")
    
    # Build project
    run_command("pnpm build", "🔨 Building the project")
    
    print("\n✅ Build completed successfully")
    
    # Check for changes
    status = subprocess.run("git status --porcelain", shell=True, capture_output=True, text=True)
    
    if not status.stdout.strip():
        print("\nℹ️  No changes to commit")
    else:
        print(f"\n✅ Found changes to commit:")
        print(status.stdout)
        
        # Stage all changes
        run_command("git add -A", "📝 Staging changes")
        
        # Commit
        run_command(
            'git commit -m "fix: radical deployment solution - complete vercel setup"',
            "💾 Creating commit"
        )
        
        # Push
        run_command("git push origin develop", "🌐 Pushing to repository")
        
        print("\n✅ Successfully pushed to develop branch!")
    
    print("\n" + "=" * 50)
    print("✨ Deployment preparation complete!")
    print("=" * 50)
    print("""
Next steps:
1. Go to https://vercel.com/dashboard
2. Check the build logs for Secure-Chat-Project
3. Wait 3-5 minutes for deployment to complete
4. Your app will be live!
    """)

if __name__ == "__main__":
    main()
