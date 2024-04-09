Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23214F12C
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681120; cv=none; b=jzQUYfUyVj8H5jjZZBfUyVqh4rSuBVNFyrkA7qUCcEiUn2xfy65Ej6HLPAu6NWXDAVMXJVh7WlRtaTtv3NLH8a66ls2AMxLkFwQc+r14uDXY9yFi72Zy++PTlMAHQW234+UvP/VBw3CqwUnT1ICtDdczL9/kp5z465KKOMms/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681120; c=relaxed/simple;
	bh=S8fnLrcOE+CG77nf2o54wARbpb7hj54ZfiXgXPNNHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Y4IqqDVDcGtSh+hKQoAdXqUBbMXxiJDxWm775mSKnXqhd01Gr9Gd2LcuZH02UcJ8FDFC/2DhLvz0NdRb/FYpqZzhQwXdLfaR4vn+DTH5iraIrmUbNh7kIa9qf5sttRRcJzdR2KcH02bdidz7+VLahfJJIk3lxjhYFg9XxRh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1+QDJC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1+QDJC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1p2oPO8w+KfWVHiOu+Xh09xtYaIwStSwHGDFRFw87II=;
	b=N1+QDJC9kbpv77IRh1PRG5c01amFnPYuOiuGCXM5RHSGYHKLktQkibi6Ew2mZ8HtwhG43H
	XfCc6L33FvRON5moqFkRhNNQi+Uzd2hdxvY3vIYkIAJB7eps6xfUWyVshJ66nm8HP+EMVi
	KvNbwFtDK19/fYRsYhc82KM2qJdw0Yk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-9sCdap08O9Gw0KgNDraUfA-1; Tue,
 09 Apr 2024 12:45:16 -0400
X-MC-Unique: 9sCdap08O9Gw0KgNDraUfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 283B21C0C643
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:16 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D911C0157E;
	Tue,  9 Apr 2024 16:45:15 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/15] gfs2: Follow-up to flag rename in sysfs status file
Date: Tue,  9 Apr 2024 18:44:53 +0200
Message-ID: <20240409164508.79570-4-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Follow up to commit e7beb8b6de1a ("gfs2: Rename SDF_DEACTIVATING to
SDF_KILL") and change the description of the SDF_KILL flag from
"Deactivating" to "Killing".

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 250f340cb44d..32d3484270f3 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -88,7 +88,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "Withdraw In Prog:         %d\n"
 		     "Remote Withdraw:          %d\n"
 		     "Withdraw Recovery:        %d\n"
-		     "Deactivating:             %d\n"
+		     "Killing:                  %d\n"
 		     "sd_log_error:             %d\n"
 		     "sd_log_flush_lock:        %d\n"
 		     "sd_log_num_revoke:        %u\n"
-- 
2.44.0

