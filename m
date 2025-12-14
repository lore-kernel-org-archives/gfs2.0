Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB33B8D7F
	for <gfs2@lists.linux.dev>; Sun, 14 Dec 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730734; cv=none; b=hCyP3hHHkTU39feV5Gz0TcFZ2ERil2Hmlvd0wLgxxsiicXodYiSDSy/KRWdy+H5omlyFD9fuKC+uoPCycE8kaNRn968OYRXoIURIXp5+nDSbKBLRpntL5pGwAuticgdXtAuySIDtfFDQU9LR3MvNMM5Q5NOxh/JNim7l5DkvRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730734; c=relaxed/simple;
	bh=ihRV2+lJdQUC5dqs92CsuBUKuy3VbMgZTcqqUhAEORk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMbM+DFc5LNN5f0k+sRuY6vrM3tiOwYiiSW85rmVsNm+aBQl/CAOIZGfNvKQ7JNGg0xgCjo5Aywl+T6stBQS+pjX7vCfwXdC8h5D30RzwKGW6edmATwlfdOYANuKY9j9X1YJgUqeIvKueqN9C7b/790IUDVNRyYuSvbBcxILapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OXijsay1; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OXijsay1"
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id UpCjviAbSl1edUpCkvyHZ1; Sun, 14 Dec 2025 17:44:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1765730660;
	bh=RBMlKerY6DIW1kq8lcAvwPe4ONKkpAi0jjadljVCmQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OXijsay17pwhtSBn4ZRgje5S9XsRyUKRqgALyHo0cw40slgU6384UqiNZfo1QRnvE
	 zBNVjXpQ5S7pf3Z2lL3onNo9yg+eaucjU4l8UKDKEui5A8QBgMxPk6a+xvjL+WvWSM
	 /mjOQXXe/X7MO3l2MWXeBvcLhdYJxZnhuFZyX7IICWFJXIRwjs+SZoaNUc64MH9qgR
	 DXTPIWJysC3yvF2Wka91HGcAXm/8vQ3xz3FHR46jMIvhI8kw51g5AJlhXlHfVShDUx
	 oP8+iSMiSqj0XU41x8heMjRn9PnOt7W0X93JW3I6NaBYTSao03Bb5WuQv+1219f5OK
	 YWLnLsll52fhg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Dec 2025 17:44:20 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	gfs2@lists.linux.dev
Subject: [PATCH] dlm: Constify struct configfs_item_operations and configfs_group_operations
Date: Sun, 14 Dec 2025 17:44:14 +0100
Message-ID: <5b7ed5a152307c7df3dbcf39b32b7c23fd8f522f.1765730638.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  29436	  12952	    384	  42772	   a714	fs/dlm/config.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  30076	  12312	    384	  42772	   a714	fs/dlm/config.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This change is possible since commits f2f36500a63b and f7f78098690d.
---
 fs/dlm/config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index a0d75b5c83c6..82cc3215663f 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -324,39 +324,39 @@ struct dlm_member_gone {
 	struct list_head list; /* space->members_gone */
 };
 
-static struct configfs_group_operations clusters_ops = {
+static const struct configfs_group_operations clusters_ops = {
 	.make_group = make_cluster,
 	.drop_item = drop_cluster,
 };
 
-static struct configfs_item_operations cluster_ops = {
+static const struct configfs_item_operations cluster_ops = {
 	.release = release_cluster,
 };
 
-static struct configfs_group_operations spaces_ops = {
+static const struct configfs_group_operations spaces_ops = {
 	.make_group = make_space,
 	.drop_item = drop_space,
 };
 
-static struct configfs_item_operations space_ops = {
+static const struct configfs_item_operations space_ops = {
 	.release = release_space,
 };
 
-static struct configfs_group_operations comms_ops = {
+static const struct configfs_group_operations comms_ops = {
 	.make_item = make_comm,
 	.drop_item = drop_comm,
 };
 
-static struct configfs_item_operations comm_ops = {
+static const struct configfs_item_operations comm_ops = {
 	.release = release_comm,
 };
 
-static struct configfs_group_operations nodes_ops = {
+static const struct configfs_group_operations nodes_ops = {
 	.make_item = make_node,
 	.drop_item = drop_node,
 };
 
-static struct configfs_item_operations node_ops = {
+static const struct configfs_item_operations node_ops = {
 	.release = release_node,
 };
 
-- 
2.52.0

