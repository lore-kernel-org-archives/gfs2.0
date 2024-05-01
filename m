Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420F18C08
	for <gfs2@lists.linux.dev>; Wed,  1 May 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584369; cv=none; b=HdC7/zMzcLuNBz8tT8sYyjcuRon4v4SLjm8XkcqReHZzGa6FS0dz4mXM9r/kUDgKo9Lw1z8dhqig7Mpf6TbH7Tz+/j9ZjuYQWP3/ltnMn65vSU3EsWfeCbRq712rT/O8FM7orrMCZ99QBWlVNPT7ES3W6jzBZklQd7vnCt1rg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584369; c=relaxed/simple;
	bh=pxyoDJoWsm4q0CjgGMyBYAGoP5WzGYzcPp/UWMDspnI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ezKKX12alXHPHO0aWXJ+kOeyTGUjI5JnVCR5TTq4cXhug0zDcdwDaSVJ5EDCjkHWRekWqQ/6Lof7lERcbPjARI61TqxzOnYaQlhRV/6E+q5p5Xzd0tvA9iIRZSr4HGehrf7bCs2nOD303uoEduWeWwxYb5HzBia0PfUjzJgAPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrY4VN7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrY4VN7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714584366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=1fD7tMSysEbq9rrBKugrf6SNTXEe4nm3wIjBQeMK/AM=;
	b=HrY4VN7Zy+ZKdX3d57Y3wEz+F4OiZ+wNDRipVkd2ZqMqZX5fARsV9tQv5JwLXji/qYvuMZ
	L1jG99A/GdUuaXQujEgH+GL8hz+D7HowCyBhQbFW3vpnwfDjtqPva/BN6gNA1/KEH/UMZK
	o/oC2eLHwRS5s1DFD2rf6wHoZtZQivs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-pWDEIl_fNPeFKPls2G9BfQ-1; Wed, 01 May 2024 13:26:03 -0400
X-MC-Unique: pWDEIl_fNPeFKPls2G9BfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BCC580591B
	for <gfs2@lists.linux.dev>; Wed,  1 May 2024 17:26:03 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 150DA1121306
	for <gfs2@lists.linux.dev>; Wed,  1 May 2024 17:26:03 +0000 (UTC)
Date: Wed, 1 May 2024 12:26:01 -0500
From: David Teigland <teigland@redhat.com>
To: gfs2@lists.linux.dev
Subject: New: use GFS2/DLM without a cluster
Message-ID: <ZjJ7KfWIVpn6kT5i@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A new daemon "dlm_sand" allows GFS2/DLM to be used without a cluster.
dlm_sand is an alternative to dlm_controld.  Where dlm_controld uses
corosync to coordinate GFS2/DLM usage and recovery, dlm_sand does the
same coordination using the SAN storage that GFS2 is already using.

This makes GFS2/DLM usage simpler, more self contained, and suited to use
cases that are more data-oriented, rather than clustering/HA oriented.
The behavior and requirements of a traditional cluster can be intrusive
and limiting when the sole interest is just using the GFS2 file system.

At the link below you'll find an initial version of dlm_sand that should
work well enough for basic usage.  The README includes how to use it, how
it works, and current limitations.  I'd like to hear if you'd find it
useful, how it works for you, or any suggestions.  Thanks!

https://pagure.io/dlm/blob/main/f/dlm_sand

