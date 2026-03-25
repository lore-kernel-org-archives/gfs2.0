Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA11531E8
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405608; cv=none; b=FOjF97A1LwpHQrDX0wQOvc7c8uW2Qgd6JdnxTr2i+ctTl+aslc/DA7aSdaqmReiwXil6BuoCejseMnRkCAE54dw0rP5tBxfuUxvKZWmKuVxJ6ZboamGMeab57r7s5DS0Vf3numHy1OoJHy+si/KzpWNkrwprgIi6xALKYKkDOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405608; c=relaxed/simple;
	bh=JsVBBn+3k5tKHaOVdq5RV/XV0HauVuTBD71nkho9ts0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKjYCuPmC+D+hWfcaggbGKcBTd7Xks7C5VfK/pGfjFWEyFUbh3W5Xz46CFR9asVbnfPCyrrSagyUEnaIfX60q3AEoV45Y3UEMiULnDHiOswIBI5DL7hOBq3mQZG6u+UYJu2IPJFTL+M4EARCiYseKnjzj+oSgr76OSzwoN4fdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAC31dzjR8Npy1O7Cw--.1218S2;
	Wed, 25 Mar 2026 10:26:43 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: Masatake YAMATO <yamato@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] fs: dlm: keep room for the final NUL in comm_addr_list_show()
Date: Wed, 25 Mar 2026 10:26:43 +0800
Message-ID: <20260325022643.770-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC31dzjR8Npy1O7Cw--.1218S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy7Cw4UZw15Kr4DXrWrZrb_yoWDCrXE9F
	929r1rCws8Cry2k3Z5JrWvvr4fAa42gr1UWr4fta93tryjqrs2v34kCr1ftanaqayUGry3
	W397Zwn8Cry2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUTMKtUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

comm_addr_list_show() subtracts the formatted address length from the
remaining configfs buffer allowance before appending the string with
strcat(). When the remaining allowance reaches exactly 0, strcat() still
writes the terminating NUL one byte past the 4096-byte configfs buffer.

Only append the next address string when there is still positive space
left after subtracting its visible length, so the trailing NUL stays
inside the output buffer.

Fixes: 55b3286d3dfd ("dlm: show addresses in configfs")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 fs/dlm/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 53cd33293042..94e4e8d3de3d 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -752,7 +752,7 @@ static ssize_t comm_addr_list_show(struct config_item *item, char *buf)
 			break;
 		}
 		allowance -= s;
-		if (allowance >= 0)
+		if (allowance > 0)
 			strcat(buf, buf0);
 		else {
 			allowance += s;
-- 
2.50.1 (Apple Git-155)

