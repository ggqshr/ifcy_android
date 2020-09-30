# 用来自动构建apk文件，并将apk发送到对应的环境中去
# dev指的是实验室内部的测试环境，pro指的是生产环境
import wexpect
from sys import argv
from pathlib import Path
from subprocess import check_output
from os import system


this_path = Path(__file__).parent.absolute()
apk_file_path = this_path.joinpath(
    "build/app/outputs/apk/release/app-release.apk")
flutter_build_cmd = "flutter build apk"


def checkout_branch(branch):
    current_branch = check_output(
        "git symbolic-ref --short -q HEAD").decode("utf-8").replace("\n", "")
    print("current branch is %s" % current_branch)
    if current_branch == branch:
        print("target and current branch is same")
        return current_branch
    system("git checkout %s" % branch)
    print("checkout to %s" % branch)
    return current_branch


def build_apk(env):
    """
    切换分支，进行build，然后切换回原来的分支
    """
    if env == 'dev':
        current_branch = checkout_branch("dev")
        system(flutter_build_cmd)
        checkout_branch(current_branch)
    if env == 'pro':
        current_branch = checkout_branch("prod")
        system(flutter_build_cmd)
        checkout_branch(current_branch)


def sent_over_scp(host, user, file, target_dir, password):
    child = wexpect.spawn("cmd.exe")
    child.expect(">")
    scp_cmd = 'scp.exe %(file)s %(user)s@%(host)s:%(remote_dir)s' % {
        "file": file,
        "user": user,
        "host": host,
        "remote_dir": target_dir,
    }
    print("exec cmd %s " % scp_cmd)
    child.sendline(scp_cmd)
    try:
        child.expect(['yes'],timeout=2)
        child.sendline("yes")
    except:
        print("already connected!")
        pass
    child.expect(["hadoop@116.56.140.193's", 'password'])
    child.sendline(password)


if __name__ == "__main__":
    env = argv[1]
    build_apk(env)
    if env == 'dev':
        sent_over_scp(
            "116.56.140.194",
            "hadoop",
            apk_file_path,
            "/home/hadoop/nginx/www/ifcy.apk",
            "1129",
        )
    elif env == 'pro':
        sent_over_scp(
            "47.107.231.51",
            "ifcy",
            apk_file_path,
            "/home/ifcy/nginx/html/ifcy.apk",
            "3vfn8BeqJvNFEfXP"
        )
